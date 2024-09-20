let
  inherit
    (builtins)
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
in {
  programs.nixvim = {
    highlight = listToAttrs (
      map
      transparent
      ["Normal" "NormalNC" "NormalSB" "NonText" "SignColumn"]
    );
    highlightOverride = listToAttrs (
      map
      diagnostic
      ["Error" "Warn" "Info" "Hint"]
    );
    plugins = {
      fidget = {
        enable = true;
        progress.display.progressIcon = {
          pattern = "pipe";
          period = 1;
        };
      };
      nvim-colorizer = {
        enable = true;
        fileTypes = ["*"];
        userDefaultOptions = {
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
}
