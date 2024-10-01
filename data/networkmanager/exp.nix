{
  connection = {
    id = "exp";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "7283f40a-9a6a-4656-95e2-989961a35647";
  };
  ipv4 = {method = "auto";};
  ipv6 = {
    addr-gen-mode = "stable-privacy";
    method = "auto";
  };
  proxy = {};
  wifi = {
    mode = "infrastructure";
    ssid = "exp";
  };
  wifi-security = {
    key-mgmt = "wpa-psk";
    psk = "$env_7283f40a_9a6a_4656_95e2_989961a35647";
    psk-flags = "0";
  };
}
