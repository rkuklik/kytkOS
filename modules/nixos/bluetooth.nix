{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.kytkos.bluetooth;
in
{
  options.kytkos.bluetooth = {
    enable = mkEnableOption "Bluetooth";
  };
  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
  };
}
