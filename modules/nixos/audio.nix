{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    mkMerge
    ;
  cfg = config.kytkos.audio;
in {
  options.kytkos.audio = {
    enable = mkEnableOption "Audio";
  };

  config = mkMerge [
    {
      hardware.pulseaudio.enable = false;
    }
    (mkIf cfg.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
      };
    })
  ];
}
