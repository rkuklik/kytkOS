{
  description = "kytkOS";

  outputs = {nixpkgs, ...} @ inputs: let
    bootstrap = import ./lib/fs.nix nixpkgs.lib;
    flowerModule = entity: {
      name = entity.base;
      value = import entity.path nixpkgs.lib;
    };
    flower =
      builtins.listToAttrs
      (
        builtins.map
        flowerModule
        (bootstrap.filters.nix (bootstrap.treeList ./lib))
      );
  in {
    inherit flower;
    nixosConfigurations = {};
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
