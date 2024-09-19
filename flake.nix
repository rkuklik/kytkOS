{
  description = "kytkOS";

  outputs = {nixpkgs, ...} @ inputs: let
    flower = import ./lib.nix nixpkgs.lib;
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
