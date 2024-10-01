{
  connection = {
    id = "labnet";
    interface-name = "wlan0";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "c94995b4-be63-4820-876b-b224426c4a32";
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
    ssid = "labnet";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_c94995b4_be63_4820_876b_b224426c4a32";
    psk-flags = "0";
  };
}
