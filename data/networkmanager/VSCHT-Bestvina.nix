{
  connection = {
    id = "VSCHT-Bestvina";
    interface-name = "wlan0";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "cf09d16d-5856-4ed5-9d21-2471562070e4";
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
    ssid = "VSCHT-Bestvina";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_cf09d16d_5856_4ed5_9d21_2471562070e4";
    psk-flags = "0";
  };
}
