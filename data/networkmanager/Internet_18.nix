{
  connection = {
    id = "Internet_18";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "3f4085c7-9486-4564-a242-d5e42fd33b69";
  };
  ipv4 = {
    method = "auto";
  };
  ipv6 = {
    addr-gen-mode = "stable-privacy";
    method = "auto";
  };
  proxy = {};
  wifi = {
    mode = "infrastructure";
    ssid = "Internet_18";
  };
  wifi-security = {
    key-mgmt = "wpa-psk";
    psk = "$env_3f4085c7_9486_4564_a242_d5e42fd33b69";
    psk-flags = "0";
  };
}
