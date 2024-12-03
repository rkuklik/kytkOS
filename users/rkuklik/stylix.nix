{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  cfg = config.styling;
in {
  options.styling = {
    enable = mkEnableOption "Custom theming" // {default = true;};
    polarity = mkOption {
      type = types.enum ["light" "dark"];
      default = "dark";
    };
    colorscheme = mkOption {
      type = types.str;
      description = "Name of colorscheme from `base16-schemes`";
      default = "catppuccin-mocha";
    };
    image = mkOption {
      type = types.nullOr types.str;
      description = "Wallpaper image, if desired";
      default = null;
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = cfg.polarity;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorscheme}.yaml";
      image =
        if cfg.image != null
        then cfg.image
        else "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images_dark/3840x2160.png";
      fonts = {
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sizes = {
          terminal = 14;
          desktop = 10;
          applications = 10;
        };
      };
      cursor = {
        package = pkgs.kdePackages.breeze;
        name = "breeze_cursors";
        size = 24;
      };
      opacity = {
        terminal = 0.8;
      };
    };
  };
}
