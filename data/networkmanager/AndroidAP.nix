{
  connection = {
    id = "AndroidAP";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "a2670714-175f-43ff-83ee-41d0af9f622d";
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
    ssid = "AndroidAP";
  };
  wifi-security = {
    key-mgmt = "wpa-psk";
    psk-flags = "1";
  };
}