{
  inputs,
  os,
  name,
  lib,
  ...
}: let
  inherit
    (lib)
    listToAttrs
    ;
  value = {};
  decrypt = paths: listToAttrs (map (name: {inherit name value;}) paths);
in {
  imports = [inputs.sops.homeManagerModules.sops];
  sops = {
    defaultSopsFile = ../../secrets/rkuklik.yaml;
    age.keyFile = "${os.users.users.${name}.home}/.config/sops/age/keys.txt";
    secrets = decrypt [
      "ssh/expect-it/bigdata"
      "ssh/expect-it/gitlab"
      "ssh/rkuklik/github"
      "vpn/expect-it/key"
      "vpn/expect-it/user"
      "vpn/expect-it/ca"
      "cargo/token"
    ];
  };
}
