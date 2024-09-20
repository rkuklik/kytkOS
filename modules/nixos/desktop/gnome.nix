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
  cfg = config.kytkos.desktop.gnome;
in {
  options.kytkos.desktop.gnome = {
    enable = mkEnableOption "Gnome";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = cfg.gnome;
  };
}
