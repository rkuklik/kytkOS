{
  inputs,
  lib,
  system,
  ...
}:
let
  inherit (lib)
    listToAttrs
    mkDefault
    mkOption
    ;

  options = [
    "distroName"
    "distroId"
    "codeName"
  ];
  value = mkOption { readOnly = false; };
  writeable = name: { inherit name value; };
in
{
  options.system.nixos = listToAttrs (map writeable options);
  config = {
    programs = {
      git.enable = true;
      nh.enable = mkDefault true;
    };
    system = {
      stateVersion = "24.11";
      nixos = {
        distroName = "kytkOS";
        distroId = "nixos";
        codeName = "Seed";
      };
    };
    nixpkgs = {
      hostPlatform = system;
      config = {
        allowUnfree = true;
      };
    };
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        use-xdg-base-directories = true;
        auto-optimise-store = true;
      };
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
      };
      channel.enable = false;
    };
  };
}
