{
  config,
  lib,
  ...
}:
let
  extraOptions.PreferredAuthentications = "publickey";
  setEnv.TERM = "linux";
  getter = _: name: config.sops.secrets.${name}.path;
  paths = builtins.mapAttrs getter;
  identities = {
    personal = paths {
      github = "keys/personal/github";
    };
    expect-it = paths {
      bigdata = "keys/expect-it/bigdata";
      gitlab = "keys/expect-it/gitlab";
    };
    cuni = paths {
      mff = "keys/cuni/mff";
      fykos = "keys/cuni/fykos";
    };
  };

  inherit (lib.hm)
    dag
    ;
in
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = identities.personal.github;
        inherit extraOptions;
      };
      "*.fykos.cz" = {
        identityFile = identities.cuni.fykos;
        inherit extraOptions;
      };
      "*.mff.cuni.cz" = {
        identityFile = identities.cuni.mff;
        user = "kuklikra";
        inherit extraOptions;
      };
      "u*.ms.mff.cuni.cz" = dag.entryBefore [ "*.mff.cuni.cz" ] {
        user = "kuklikra";
        extraOptions = {
          PreferredAuthentications = "keyboard-interactive";
          PubkeyAuthentication = "no";
        };
      };
      "gitlab.expect-it.local" = {
        hostname = "gitlab.expect-it.local";
        identityFile = identities.expect-it.gitlab;
        inherit extraOptions;
      };
      bigdata = {
        hostname = "bigdata.expect-it.local";
        identityFile = identities.expect-it.bigdata;
        inherit extraOptions;
      };
      minio = {
        hostname = "192.168.1.206";
        identityFile = identities.expect-it.bigdata;
        inherit setEnv;
      };
      synology = {
        hostname = "192.168.1.68";
        inherit setEnv;
      };
    };
  };
}
