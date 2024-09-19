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
  cfg = config.kytkos.memory;
  mkDisableOption = description: mkEnableOption description // {default = true;};
in {
  options.kytkos.memory = {
    tmp = mkDisableOption "Use tmpfs in /tmp";
    compress = mkDisableOption "Download more RAM";
  };
  config = {
    boot.tmp = {
      useTmpfs = cfg.tmp;
      cleanOnBoot = true;
    };
    systemd.services.nix-daemon = mkIf cfg.tmp {
      environment.TMPDIR = "/var/tmp";
    };
    zramSwap.enable = cfg.compress;
  };
}
