{
  pkgs,
  config,
  flower,
  lib,
  ...
}: let
  inherit
    (lib)
    concatStringsSep
    escapeShellArg
    getExe
    listToAttrs
    mkEnableOption
    mkIf
    ;
  cfg = config.kytkos.net;

  ini = (pkgs.formats.ini {}).generate;

  imported = transformer: dir:
    map
    transformer
    (flower.fs.treeList ../../../data/${dir});

  envsubst = getExe pkgs.envsubst;
  iwdDir = "/var/lib/iwd";
  iwdProfiles = entity: let
    escapedName = escapeShellArg entity.base;
    contents = import entity.path;
  in "${envsubst} -i ${ini escapedName contents} > ${iwdDir}/${escapedName}.8021x";

  nmProfiles = entity: {
    name = entity.base;
    value = import entity.path;
  };
in {
  options.kytkos.net = {
    wireless = mkEnableOption "Wireless config";
  };
  config = mkIf cfg.wireless {
    sops.secrets."networkmanager" = {
      restartUnits = [
        "iwd-ensure-provisioning.service"
        "NetworkManager-ensure-profiles.service"
      ];
    };
    systemd.services.iwd-ensure-provisioning = {
      description = "Ensure that iwd provisioning files";
      wantedBy = ["multi-user.target"];
      before = ["network-online.target"];
      after = ["NetworkManager.service"];
      script =
        # bash
        ''
          mkdir -p ${iwdDir}
          ${concatStringsSep "\n" (imported iwdProfiles "iwd")}
          ${pkgs.networkmanager}/bin/nmcli connection reload
        '';
      serviceConfig = {
        EnvironmentFile = config.networking.networkmanager.ensureProfiles.environmentFiles;
        UMask = "0177";
        Type = "oneshot";
      };
    };
    networking = {
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
        ensureProfiles = {
          environmentFiles = [
            config.sops.secrets.networkmanager.path
            pkgs.certs.certEnv
          ];
          profiles = listToAttrs (imported nmProfiles "networkmanager");
        };
      };
      wireless.iwd.settings = {
        IPv6 = {
          Enabled = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };
}
