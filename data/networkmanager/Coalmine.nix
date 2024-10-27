{
  connection = {
    id = "Coalmine";
    metered = "1";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "fd08818d-1c15-4b9d-b798-f9cdc74fe4f9";
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
    ssid = "Coalmine";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_fd08818d_1c15_4b9d_b798_f9cdc74fe4f9";
    psk-flags = "0";
  };
}
