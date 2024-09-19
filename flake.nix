{
  description = "kytkOS";

  outputs = {nixpkgs, ...} @ inputs: let
    flower = import ./lib.nix nixpkgs.lib;

    inherit (flower.fs) include;

    hosts = let
      inherit (flower.os.systems) linux;
    in {
      nixos = {
        vm = linux.x86_64;
      };
    };

    platforms = {
      nixos = {
        name = "nixos";
        builder = nixpkgs.lib.nixosSystem;
        sharedModules = [];
      };
    };

    osbuilder = {
      name,
      builder,
      sharedModules,
    }: hostname: system: let
      modules =
        sharedModules
        ++ include ./modules/${name}
        ++ include ./hosts/${hostname};
      specialArgs = {
        inherit
          hostname
          inputs
          system
          ;
      };
    in
      builder {
        inherit
          modules
          specialArgs
          ;
      };

    configurations = name:
      builtins.mapAttrs
      (osbuilder platforms.${name})
      hosts.${name};
  in {
    inherit flower;
    nixosConfigurations = configurations "nixos";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
