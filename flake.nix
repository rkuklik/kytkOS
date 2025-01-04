{
  description = "kytkOS";

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      sops,
      disko,
      ...
    }@inputs:
    let
      flower = import ./lib.nix nixpkgs.lib;

      inherit (flower.fs) include;

      hosts =
        let
          inherit (flower.os.systems) linux;
        in
        {
          nixos = {
            inspiron = {
              hostname = "inspiron";
              system = linux.x86_64;
              systemModules = [
                nixos-hardware.nixosModules.dell-inspiron-5515
              ];
            };
          };
        };

      platforms = {
        nixos = {
          name = "nixos";
          builder = nixpkgs.lib.nixosSystem;
          sharedModules = [
            home-manager.nixosModules.home-manager
            sops.nixosModules.sops
            disko.nixosModules.disko
          ];
        };
      };

      osbuilder =
        {
          name,
          builder,
          sharedModules,
        }:
        {
          hostname,
          system,
          systemModules,
        }:
        let
          modules =
            [ ] ++ sharedModules ++ systemModules ++ include ./modules/${name} ++ include ./hosts/${hostname};
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

      configurations = name: builtins.mapAttrs (_: osbuilder platforms.${name}) hosts.${name};
    in
    {
      inherit flower;
      nixosConfigurations = configurations "nixos";
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    rust = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
