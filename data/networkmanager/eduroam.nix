{
  "802-1x" = {
    domain-suffix-match = "cuni.cz";
    eap = "peap;";
    identity = "96388105@cuni.cz";
    password = "$env_a3ab6936_aa8e_47f4_87e5_253b8ca9a17c";
    password-flags = "0";
    phase2-auth = "mschapv2";
  };
  connection = {
    id = "eduroam";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "a3ab6936-aa8e-47f4-87e5-253b8ca9a17c";
  };
  ipv4 = {
    method = "auto";
  };
  ipv6 = {
    addr-gen-mode = "stable-privacy";
    method = "auto";
  };
  proxy = {};
  wifi = {
    mode = "infrastructure";
    ssid = "eduroam";
  };
  wifi-security = {
    key-mgmt = "wpa-eap";
  };
}
