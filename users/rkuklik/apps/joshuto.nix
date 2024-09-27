{
  pkgs,
  lib,
  ...
}: let
  preview = pkgs.writeShellApplication {
    name = "joshuto-preview";
    bashOptions = [
      "noclobber"
      "noglob"
      "nounset"
      "pipefail"
    ];
    excludeShellChecks = [
      "SC2034"
      "SC2317"
    ];
    # do not include deps here, depend on env
    runtimeInputs = [pkgs.file];
    text = ''
      # Parse args
      FILE_PATH=""
      PREVIEW_WIDTH=10
      PREVIEW_HEIGHT=10

      while [ "$#" -gt 0 ]; do
        case "$1" in
          "--path")
            shift
            FILE_PATH="$1"
            ;;
          "--preview-width")
            shift
            PREVIEW_WIDTH="$1"
            ;;
            "--preview-height")
            shift
            PREVIEW_HEIGHT="$1"
            ;;
        esac
        shift
      done

      # Setup handlers
      extension_handler() {
        local extension="$1"
        case "$extension" in
          ## Archive
          a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "$FILE_PATH" && exit 0
            bsdtar --list --file "$FILE_PATH" && exit 0
            ;;
          rar)
            ## Avoid password prompt by providing empty password
            unrar lt -p- -- "$FILE_PATH" && exit 0
            ;;
          7z)
            ## Avoid password prompt by providing empty password
            7z l -p -- "$FILE_PATH" && exit 0
            ;;
          ## PDF
          pdf)
            ## Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "$FILE_PATH" - | \
              fmt -w "$PREVIEW_WIDTH" && exit 0
            mutool draw -F txt -i -- "$FILE_PATH" 1-10 | \
              fmt -w "$PREVIEW_WIDTH" && exit 0
            exiftool "$FILE_PATH" && exit 0
            ;;
          ## BitTorrent
          torrent)
            transmission-show -- "$FILE_PATH" && exit 0
            ;;
          ## OpenDocument
          odt|ods|odp|sxw)
            ## Preview as text conversion
            odt2txt "$FILE_PATH" && exit 0
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "$FILE_PATH" && exit 0
            ;;
          ## XLSX
          xlsx)
            ## Preview as csv conversion
            ## Uses: https://github.com/dilshod/xlsx2csv
            xlsx2csv -- "$FILE_PATH" && exit 0
            ;;
          ## HTML
          htm|html|xhtml)
            ## Preview as text conversion
            w3m -dump "$FILE_PATH" && exit 0
            lynx -dump -- "$FILE_PATH" && exit 0
            elinks -dump "$FILE_PATH" && exit 0
            pandoc -s -t markdown -- "$FILE_PATH" && exit 0
            ;;
          ## JSON
          json|ipynb)
            jq --color-output . "$FILE_PATH" && exit 0
            python -m json.tool -- "$FILE_PATH" && exit 0
            ;;

          ## Direct Stream Digital/Transfer (DSDIFF) and wavpack aren't detected
          ## by file(1).
          dff|dsf|wv|wvc)
            mediainfo "$FILE_PATH" && exit 0
            exiftool "$FILE_PATH" && exit 0
            ;;
        esac
      }

      mime_handler() {
        local mimetype="$1"
        case "$mimetype" in
          ## RTF and DOC
          text/rtf|*msword)
            ## Preview as text conversion
            ## note: catdoc does not always work for .doc files
            ## catdoc: http://www.wagner.pp.ru/~vitus/software/catdoc/
            catdoc -- "$FILE_PATH" && exit 0
            ;;
          ## DOCX, ePub, FB2 (using markdown)
          ## You might want to remove "|epub" and/or "|fb2" below if you have
          ## uncommented other methods to preview those formats
          *wordprocessingml.document|*/epub+zip|*/x-fictionbook+xml)
            ## Preview as markdown conversion
            pandoc -s -t markdown -- "$FILE_PATH" | bat -l markdown \
              --color=always --paging=never \
              --style=plain \
              --terminal-width="$PREVIEW_WIDTH" && exit 0
            ;;
          ## E-mails
          message/rfc822)
            ## Parsing performed by mu: https://github.com/djcb/mu
            mu view -- "$FILE_PATH" && exit 0
            ;;
          ## XLS
          *ms-excel)
            ## Preview as csv conversion
            ## xls2csv comes with catdoc:
            ##   http://www.wagner.pp.ru/~vitus/software/catdoc/
            xls2csv -- "$FILE_PATH" && exit 0
            ;;
          ## Text
          text/* | */xml)
            bat --color=always --paging=never \
              --style=plain \
              --terminal-width="$PREVIEW_WIDTH" \
              "$FILE_PATH" && exit 0
            cat "$FILE_PATH" && exit 0
            ;;

          ## DjVu
          image/vnd.djvu)
            ## Preview as text conversion (requires djvulibre)
            djvutxt "$FILE_PATH" | fmt -w "$PREVIEW_WIDTH" && exit 0
            exiftool "$FILE_PATH" && exit 0
            ;;
          ## Image
          image/*)
            ## Preview as text conversion
            exiftool "$FILE_PATH" && exit 0
            ;;
          ## Video and audio
          video/* | audio/*)
            mediainfo "$FILE_PATH" && exit 0
            exiftool "$FILE_PATH" && exit 0
            ;;
        esac
      }

      extension_handler "$(printf "%s" "''${FILE_PATH##*.}" | tr '[:upper:]' '[:lower:]')"
      mime_handler "$(file --dereference --brief --mime-type -- "$FILE_PATH")"

      exit 1
    '';
  };
in {
  programs.joshuto = {
    enable = true;
    settings = {
      scroll_offset = 6;
      xdg_open = false;
      xdg_open_fork = true;
      use_trash = true;
      watch_files = true;
      display = {
        mode = "default";
        automatically_count_files = true;
        collapse_preview = true;
        scroll_offset = 6;
        column_ratio = [1 2 2];
        show_borders = true;
        show_hidden = true;
        show_icons = true;
        tilde_in_titlebar = true;
        line_number_style = "relative";
        sort = {
          method = "natural";
          case_sensitive = false;
          directories_first = true;
          reverse = false;
        };
      };
      preview = {
        max_preview_size = 2097152;
        preview_script = lib.getExe preview;
      };
      tab.home_page = "home";
    };
  };
}
