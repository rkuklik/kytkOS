{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.kytkos.containers;
in {
  options.kytkos.containers = {
    enable = mkEnableOption "OCI containers";
    compose = mkEnableOption "Compose utility";
  };
  config = mkIf cfg.enable {
    virtualisation = {
      oci-containers.backend = "podman";
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    environment.systemPackages = mkIf cfg.compose [
      pkgs.docker-compose
    ];
  };
}
