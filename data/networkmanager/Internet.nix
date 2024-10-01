{
  connection = {
    id = "Internet";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "7f2a952b-fc45-49d5-bd66-ba3d70534a81";
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
    ssid = "Internet";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_7f2a952b_fc45_49d5_bd66_ba3d70534a81";
    psk-flags = "0";
  };
}
