{config, ...}: let
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
  stylix.targets.nixvim.enable = false;
  programs.nixvim = {
    highlight = listToAttrs (
      map
      transparent
      [
        "Normal"
        "NormalNC"
        "NormalFloat"
        "Pmenu"
        "StatusLine"
        "StatusLineNC"
        "TabLineFill"
        "WinSeparator"
        "NonText"
        "SignColumn"
        "VertSplit"
        "Folded"
      ]
    );
    highlightOverride = listToAttrs (
      map
      diagnostic
      ["Error" "Warn" "Info" "Hint"]
    );
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
        term_colors = true;
        integrations = {
          fidget = true;
        };
      };
    };
    plugins = {
      fidget = {
        enable = true;
        progress.display.progressIcon = {
          pattern = "pipe";
          period = 1;
        };
      };
      web-devicons.enable = true;
      colorizer = {
        enable = true;
        settings = {
          filetypes = ["*"];
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
