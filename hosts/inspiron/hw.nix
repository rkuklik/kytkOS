{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
      kernelModules = [];
    };
    loader = {
      grub.device = "/dev/vda";
      grub.gfxmodeBios = "1920x1080";
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/d0d039ee-a355-4bdb-b6e8-8ffca73aec3c";
      fsType = "ext4";
    };
    "/kytkos" = {
      device = "kytkos";
      fsType = "virtiofs";
    };
  };

  swapDevices = [];

  services.spice-vdagentd.enable = true;
}
