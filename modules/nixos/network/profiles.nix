{
  pkgs,
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
    ensureProfiles = {
      environmentFiles = [
        config.sops.secrets.networkmanager.path
        pkgs.certs.certEnv
      ];
      profiles = lib.listToAttrs profiles;
    };
  };
}
