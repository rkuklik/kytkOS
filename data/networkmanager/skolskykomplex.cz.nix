{
  connection = {
    id = "skolskykomplex.cz";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "aaae4b9b-2f6f-48d7-891a-b8901aa22d4d";
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
    mode = "infrastructure";
    ssid = "skolskykomplex.cz";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_aaae4b9b_2f6f_48d7_891a_b8901aa22d4d";
    psk-flags = "0";
  };
}
