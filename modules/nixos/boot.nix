{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkOption
    types
    ;
  cfg = config.kytkos.boot;
in {
  options.kytkos.boot = {
    loader = mkOption {
      description = "Which bootloader to user";
      type = types.enum ["grub" "systemd-boot"];
    };
    memtest = mkEnableOption "Memory testing";
  };

  config.boot = {
    initrd.systemd.enable = true;
    loader = {
      grub = {
        enable = cfg.loader == "grub";
        useOSProber = true;
        enableCryptodisk = true;
        efiSupport = true;
        memtest86.enable = cfg.memtest;
      };
      systemd-boot = {
        enable = cfg.loader == "systemd-boot";
        memtest86.enable = cfg.memtest;
      };
    };
  };
}
