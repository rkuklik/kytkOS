{
  lib,
  system,
  hostname,
  ...
}: let
  inherit
    (lib)
    listToAttrs
    mkOption
    ;

  options = ["distroName" "distroId" "codeName"];
  value = mkOption {readOnly = false;};
  writeable = name: {inherit name value;};
in {
  options.system.nixos = listToAttrs (map writeable options);
  config = {
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
        use-xdg-base-directories = true;
      };
    };
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
      };
    };
    networking.hostName = hostname;
  };
}
