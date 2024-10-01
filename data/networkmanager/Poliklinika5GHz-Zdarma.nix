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
    psk = "$env_78079426_d003_4920_8228_563be0930cdf";
    psk-flags = "0";
  };
}
