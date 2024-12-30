{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    concatStringsSep
    escapeShellArg
    filterAttrs
    getExe
    mkEnableOption
    mkIf
    ;

  cfg = config.kytkos.net;
  ini = (pkgs.formats.ini {}).generate;
  envsubst = getExe pkgs.envsubst;
  iwdDir = "/var/lib/iwd";
  substituter = conf: let
    name = escapeShellArg conf.name;
    type = escapeShellArg conf.type;
    contents = filterAttrs (name: value: name != "name" && name != "type") conf;
  in "${envsubst} -i ${ini name contents} > ${iwdDir}/${name}.${type}";
in {
  options.kytkos.net = {
    enable = mkEnableOption "Network settings" // {default = true;};
  };
  config = mkIf cfg.enable {
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
          ${concatStringsSep "\n" (map substituter cfg.iwd)}
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
