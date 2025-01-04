{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    ;
  cfg = config.kytkos.audio;
  enable = cfg.enable;
in
{
  options.kytkos.audio = {
    enable = mkEnableOption "Audio";
  };

  config = {
    security.rtkit.enable = enable;
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = enable;
        alsa = {
          enable = enable;
          support32Bit = enable;
        };
        pulse.enable = enable;
        jack.enable = enable;
      };
    };
  };
}
