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
    mapAttrsToList
    getExe
    ;

  ini = (pkgs.formats.ini {}).generate;

  envsubst = getExe pkgs.envsubst;
  base = "/var/lib/iwd";

  substituter = _: entity: let
    escapedName = escapeShellArg entity.base;
    contents = import entity.path;
  in "${envsubst} -i ${ini escapedName contents} > ${base}/${escapedName}.8021x";
  creationCommands = mapAttrsToList substituter (flower.fs.tree ../../../data/iwd);
in {
  sops.secrets."networkmanager" = {
    restartUnits = ["iwd-ensure-provisioning.service"];
  };
  systemd.services.iwd-ensure-provisioning = {
    description = "Ensure that iwd provisioning files";
    wantedBy = ["multi-user.target"];
    before = ["network-online.target"];
    after = ["NetworkManager.service"];
    script =
      # bash
      ''
        mkdir -p ${base}
        ${concatStringsSep "\n" creationCommands}
        ${pkgs.networkmanager}/bin/nmcli connection reload
      '';
    serviceConfig = {
      EnvironmentFile = config.networking.networkmanager.ensureProfiles.environmentFiles;
      UMask = "0177";
      Type = "oneshot";
    };
  };
}
