{
  description = "kytkOS";

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
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
        sharedModules = [
          home-manager.nixosModules.home-manager
        ];
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
          flower
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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };
}
