{
  connection = {
    id = "labnet";
    interface-name = "wlan0";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "c94995b4-be63-4820-876b-b224426c4a32";
  };
  ipv4 = {method = "auto";};
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
    leap-password-flags = "1";
    psk-flags = "1";
    wep-key-flags = "1";
  };
}
