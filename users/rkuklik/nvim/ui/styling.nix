let
  inherit (builtins)
    map
    listToAttrs
    ;
  diagnostic = level: {
    name = "DiagnosticUnderline${level}";
    value.underline = true;
  };
  transparent = group: {
    name = group;
    value = {
      bg = "none";
      ctermbg = "none";
    };
  };
  transparency = map transparent [
    "Normal"
    "NormalNC"
    "NormalFloat"
    "LineNr"
    "CursorLineNr"
    "LineNrAbove"
    "LineNrBelow"
    "SignColumn"
    "WinSeparator"
  ];
  underline = map diagnostic [
    "Error"
    "Warn"
    "Info"
    "Hint"
  ];
in
{
  programs.nixvim = {
    highlightOverride = listToAttrs (transparency ++ underline);
    plugins = {
      fidget = {
        enable = true;
        settings.progress.display.progress_icon = {
          pattern = "pipe";
          period = 1;
        };
      };
      web-devicons.enable = true;
      colorizer = {
        enable = true;
        settings = {
          filetypes = [ "*" ];
          user_default_options = {
            RGB = true;
            RRGGBB = true;
            names = true;
            RRGGBBAA = true;
            AARRGGBB = false;
            rgb_fn = true;
            hsl_fn = true;
            css = true;
            css_fn = true;
            mode = "background";
            tailwind = true;
            virtualtext = "■";
          };
        };
      };
    };
  };
}
