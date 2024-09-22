{
  pkgs,
  config,
  lib,
  ...
}: let
  name = "plasmaflower";
  pretty = "Plasma Flower";
  id = "cz.kytkos.${name}";
  stylecfg = config.stylix;
  fonts = stylecfg.fonts;

  formatValue = value:
    if builtins.isBool value
    then lib.boolToString value
    else builtins.toString value;

  formatSection = path: data: let
    header = lib.concatStrings (map (p: "[${p}]") path);
    formatChild = name: formatLines (path ++ [name]);
    children = lib.mapAttrsToList formatChild data;
    partitioned = lib.partition builtins.isString children;
    directChildren = partitioned.right;
    indirectChildren = partitioned.wrong;
  in
    lib.optional (directChildren != []) header
    ++ directChildren
    ++ lib.flatten indirectChildren;

  formatLines = path: data:
    if builtins.isAttrs data
    then
      if data ? _immutable
      then
        if builtins.isAttrs data.value
        then formatSection (path ++ ["$i"]) data.value
        else "${lib.last path}[$i]=${formatValue data.value}"
      else formatSection path data
    else "${lib.last path}=${formatValue data}";

  formatConfig = data:
    lib.concatStringsSep "\n" (formatLines [] data);

  customColors = config.lib.stylix.colors;

  # PascalCase is the standard naming for color scheme files. Schemes named
  # in kebab-case will load when selected manually, but don't work with a
  # look and feel package.
  colorschemeSlug =
    lib.concatStrings
    (builtins.filter builtins.isString
      (builtins.split "[^a-zA-Z]" customColors.scheme));

  colorEffect = {
    ColorEffect = 0;
    ColorAmount = 0;
    ContrastEffect = 1;
    ContrastAmount = 0.5;
    IntensityEffect = 0;
    IntensityAmount = 0;
  };

  colors = with customColors; {
    BackgroundNormal = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
    BackgroundAlternate = "${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}";
    DecorationFocus = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}";
    DecorationHover = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}";
    ForegroundNormal = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";
    ForegroundActive = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";
    ForegroundInactive = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";
    ForegroundLink = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";
    ForegroundVisited = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";
    ForegroundNegative = "${base08-rgb-r},${base08-rgb-g},${base08-rgb-b}";
    ForegroundNeutral = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}";
    ForegroundPositive = "${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b}";
  };

  colorscheme = with customColors; {
    General = {
      ColorScheme = colorschemeSlug;
      Name = scheme;
    };

    "ColorEffects:Disabled" = colorEffect;
    "ColorEffects:Inactive" = colorEffect;

    "Colors:Window" = colors;
    "Colors:View" = colors;
    "Colors:Button" = colors;
    "Colors:Tooltip" = colors;
    "Colors:Complementary" = colors;
    "Colors:Selection" =
      colors
      // {
        BackgroundNormal = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}";
        BackgroundAlternate = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}";
        ForegroundNormal = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
        ForegroundActive = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
        ForegroundInactive = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
        ForegroundLink = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
        ForegroundVisited = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
      };

    WM = {
      activeBlend = "${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b}";
      activeBackground = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
      activeForeground = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";
      inactiveBlend = "${base03-rgb-r},${base03-rgb-g},${base03-rgb-b}";
      inactiveBackground = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";
      inactiveForeground = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";
    };
  };

  wallpaperMetadata = {
    KPlugin = {
      Id = id;
      Name = pretty;
    };
  };

  # HACK: lookAndFeelDefaults didn't set this
  kwinrc."org.kde.kdecoration2" = {
    library = "arstotzka";
    theme = "Arstotzka";
    BorderSize = "Tiny";
    BorderSizeAuto = false;
  };

  lookAndFeelMetadata = {
    KPlugin = {
      Id = id;
      Name = pretty;
      Description = "Generated from your Home Manager configuration";
      ServiceTypes = ["Plasma/LookAndFeel"];
      Website = "https://github.com/danth/stylix";
    };
    KPackageStructure = "Plasma/LookAndFeel";
  };

  lookAndFeelDefaults = {
    inherit kwinrc;
    plasmarc.Theme.name = "default";
    kdeglobals = {
      KDE.widgetStyle = "Breeze";
      General.ColorScheme = colorschemeSlug;
    };

    # This only takes effect on the first login.
    Wallpaper.Image = id;
  };

  # Contains a wallpaper package, a colorscheme file, and a look and feel
  # package which depends on both.
  themePackage =
    pkgs.runCommandLocal "kde-theme" {
      colorscheme = formatConfig colorscheme;
      wallpaperMetadata = builtins.toJSON wallpaperMetadata;
      wallpaperImage = stylecfg.image;
      lookAndFeelMetadata = builtins.toJSON lookAndFeelMetadata;
      lookAndFeelDefaults = formatConfig lookAndFeelDefaults;
    } ''
      write_text() {
        mkdir --parents "$(dirname "$2")"
        printf '%s\n' "$1" >"$2"
      }

      PATH="${pkgs.imagemagick}/bin:$PATH"

      wallpaper="$out/share/wallpapers/${name}"
      look_and_feel="$out/share/plasma/look-and-feel/${name}"

      mkdir --parents "$wallpaper/contents/images"

      magick \
        "$wallpaperImage" \
        -thumbnail 400x250 \
        "$wallpaper/contents/screenshot.png"

      dimensions="$(identify -ping -format '%wx%h' "$wallpaperImage")"
      magick "$wallpaperImage" "$wallpaper/contents/images/$dimensions.png"

      write_text \
        "$colorscheme" \
        "$out/share/color-schemes/${colorschemeSlug}.colors"

      write_text "$wallpaperMetadata" "$wallpaper/metadata.json"
      write_text "$lookAndFeelMetadata" "$look_and_feel/metadata.json"
      write_text "$lookAndFeelDefaults" "$look_and_feel/contents/defaults"
    '';
in {
  config = {
    home.packages = [themePackage pkgs.arstotzka];
    programs.plasma = {
      workspace = {
        lookAndFeel = id;
        colorScheme = colorschemeSlug;
        cursor = {
          theme = stylecfg.cursor.name;
          size = stylecfg.cursor.size;
        };
      };
      fonts = let
        inherit (fonts) sansSerif sizes monospace;
        desktop = {
          family = sansSerif.name;
          pointSize = sizes.desktop;
        };
      in {
        general = {
          family = sansSerif.name;
          pointSize = sizes.applications;
        };
        fixedWidth = {
          family = monospace.name;
          pointSize = sizes.terminal;
        };
        menu = desktop;
        toolbar = desktop;
        small = desktop // {pointSize = desktop.pointSize * 0.8;};
        windowTitle = desktop;
      };
      configFile = {
        kded5rc.Module-gtkconfig.autoload = {
          immutable = true;
          value = false;
        };
        inherit kwinrc;
      };
    };
  };
}
