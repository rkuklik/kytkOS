{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.kytkos.desktop.hyprland;
in {
  options.kytkos.desktop.hyprland = {
    enable = mkEnableOption "KDE Plasma";
  };

  config = mkIf cfg.enable {
    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
    };
  };
}