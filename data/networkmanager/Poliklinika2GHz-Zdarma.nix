{
  connection = {
    id = "Poliklinika2GHz-Zdarma";
    interface-name = "wlan0";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "3748ee52-5728-475c-93f3-14edbdaa7678";
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
    ssid = "Poliklinika2GHz-Zdarma";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_3748ee52_5728_475c_93f3_14edbdaa7678";
    psk-flags = "0";
  };
}
