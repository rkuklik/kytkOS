{ config, ... }:
let
  extraOptions.PreferredAuthentications = "publickey";
  setEnv.TERM = "linux";
  getter = _: name: config.sops.secrets.${name}.path;
  identities = builtins.mapAttrs getter {
    github = "ssh/rkuklik/github";
    bigdata = "ssh/expect-it/bigdata";
    gitlab = "ssh/expect-it/gitlab";
  };
in
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      github = {
        hostname = "github.com";
        identityFile = identities.github;
        inherit extraOptions;
      };
      gitea = {
        hostname = "git.fykos.cz";
        identityFile = identities.github;
        inherit extraOptions;
      };
      gitlab = {
        hostname = "gitlab.expect-it.local";
        identityFile = identities.gitlab;
        inherit extraOptions;
      };
      bigdata = {
        hostname = "bigdata.expect-it.local";
        identityFile = identities.bigdata;
        inherit extraOptions;
      };
      minio = {
        hostname = "192.168.1.206";
        identityFile = identities.bigdata;
        inherit setEnv;
      };
      synology = {
        hostname = "192.168.1.68";
        inherit setEnv;
      };
    };
  };
}
