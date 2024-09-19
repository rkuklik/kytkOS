{
  config,
  lib,
  ...
}: let
  cfg = config.kytkos.net.wifi;
  inherit
    (lib)
    mkIf
    mkEnableOption
    ;
in {
  options.kytkos.net.wifi = {
    enable = mkEnableOption "Wi-Fi";
  };

  config.networking.networkmanager = mkIf cfg.enable {
    enable = true;
    wifi.backend = "iwd";
  };
}
