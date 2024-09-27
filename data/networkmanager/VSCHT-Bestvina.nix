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
    leap-password-flags = "1";
    psk-flags = "1";
    wep-key-flags = "1";
  };
}
