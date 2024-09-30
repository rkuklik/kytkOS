{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkDefault
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  cfg = config.kytkos.boot;
in {
  options.kytkos.boot = {
    loader = mkOption {
      description = "Which bootloader to user";
      type = types.enum ["grub" "systemd-boot"];
    };
    mode = mkOption {
      description = "Type of firmware";
      type = types.enum ["uefi" "bios"];
    };
    memtest = mkEnableOption "Memory testing";
  };

  config.assertions = [
    {
      assertion = (cfg.loader == "systemd-boot") -> (cfg.mode == "uefi");
      message = "systemd-boot only runs in uefi mode";
    }
  ];
  config.boot = {
    initrd.systemd.enable = true;
    loader = {
      grub = {
        enable = cfg.loader == "grub";
        useOSProber = true;
        enableCryptodisk = true;
        efiSupport = cfg.mode == "uefi";
        gfxmodeBios = mkDefault "auto";
        gfxmodeEfi = mkDefault "auto";
        device = mkIf (cfg.loader == "grub") (mkDefault "nodev");
        memtest86.enable = cfg.memtest;
      };
      systemd-boot = {
        enable = cfg.loader == "systemd-boot";
        memtest86.enable = cfg.memtest;
      };
    };
  };
}
