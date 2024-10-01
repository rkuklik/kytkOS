{
  connection = {
    id = "WIFIucitel";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "a8f7e1a2-3d7d-4339-97fd-533e3647e0a8";
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
    ssid = "WIFIucitel";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_a8f7e1a2_3d7d_4339_97fd_533e3647e0a8";
    psk-flags = "0";
  };
}
