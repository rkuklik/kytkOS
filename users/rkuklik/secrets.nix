{
  inputs,
  os,
  name,
  lib,
  ...
}:
let
  inherit (lib)
    listToAttrs
    ;
  value = { };
  decrypt = paths: listToAttrs (map (name: { inherit name value; }) paths);
in
{
  imports = [ inputs.sops.homeManagerModules.sops ];
  sops = {
    defaultSopsFile = ../../secrets/rkuklik.yaml;
    age.keyFile = "${os.users.users.${name}.home}/.config/sops/age/keys.txt";
    secrets = decrypt [
      "keys/expect-it/bigdata"
      "keys/expect-it/gitlab"
      "keys/personal/github"
      "keys/cuni/mff"
      "keys/cuni/fykos"
      "vpn/expect-it/key.pem"
      "vpn/expect-it/user.pem"
      "vpn/expect-it/ca.pem"
      "vpn/expect-it/tls.pem"
      "cargo/token"
    ];
  };
}
