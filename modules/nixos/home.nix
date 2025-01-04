{
  config,
  inputs,
  flower,
  ...
}:
let
  os = config;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = flower.fs.include ../home-manager;
    extraSpecialArgs = {
      inherit
        flower
        inputs
        os
        ;
    };
    backupFileExtension = "home-manager-backup";
  };
}
