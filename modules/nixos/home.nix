{
  config,
  inputs,
  lib,
  ...
}:
let
  os = config;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = lib.flower.fs.include ../home-manager;
    extraSpecialArgs = {
      inherit
        inputs
        os
        ;
    };
    backupFileExtension = "home-manager-backup";
  };
}
