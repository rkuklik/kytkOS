{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    ;
  cfg = config.kytkos.audio;
  enable = cfg.enable;
in {
  options.kytkos.audio = {
    enable = mkEnableOption "Audio";
  };

  config = {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = enable;
    services.pipewire = {
      enable = enable;
      alsa = {
        enable = enable;
        support32Bit = enable;
      };
      pulse.enable = enable;
      jack.enable = enable;
    };
  };
}
