{
  connection = {
    id = "GopasWifi";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "9221b1db-afcf-4fc9-854d-823f1a753d94";
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
    ssid = "GopasWifi";
  };
  wifi-security = {
    key-mgmt = "wpa-psk";
    psk-flags = "1";
  };
}
