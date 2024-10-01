{
  config,
  flower,
  lib,
  ...
}: let
  mapper = entity: {
    name = entity.base;
    value = import entity.path;
  };
  files = flower.fs.treeList ../../../data/networkmanager;
  profiles = map mapper files;
in {
  sops.secrets."networkmanager" = {
    restartUnits = ["NetworkManager-ensure-profiles.service"];
  };
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    ensureProfiles = {
      environmentFiles = [
        config.sops.secrets.networkmanager.path
      ];
      profiles = lib.listToAttrs profiles;
    };
  };
}
