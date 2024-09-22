{
  inputs,
  lib,
  os,
  ...
}: let
  flaked = name: inputs.${name}.homeManagerModules.${name};
  modules = [
    "plasma-manager"
    "stylix"
    "nixvim"
  ];
in {
  imports = map flaked modules;
  config = {
    programs.home-manager.enable = true;
    home.stateVersion = lib.mkDefault os.system.stateVersion;
  };
}
