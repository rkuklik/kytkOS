{
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
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    ensureProfiles.profiles = lib.listToAttrs profiles;
  };
}
