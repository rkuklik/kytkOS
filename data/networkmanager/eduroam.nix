{
  "802-1x" = {
    altsubject-matches = "DNS:radius1.eduroam.cuni.cz;DNS:radius2.eduroam.cuni.cz;";
    # SHA-1 is not supported
    domain-suffix-match = "cuni.cz";
    ca-cert = "$eduroam_cuni";
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
    addr-gen-mode = "default";
    method = "auto";
  };
  proxy = {};
  wifi = {
    ssid = "eduroam";
  };
  wifi-security = {
    key-mgmt = "wpa-eap";
    group = "ccmp;tkip;";
    pairwise = "ccmp;";
    proto = "rsn;";
  };
}
