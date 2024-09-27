{
  connection = {
    id = "Poliklinika5GHz-Zdarma";
    interface-name = "wlan0";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "78079426-d003-4920-8228-563be0930cdf";
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
    ssid = "Poliklinika5GHz-Zdarma";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    leap-password-flags = "1";
    psk-flags = "1";
    wep-key-flags = "1";
  };
}
