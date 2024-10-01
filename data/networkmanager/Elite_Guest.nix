{
  connection = {
    id = "Elite_Guest";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "003ae82c-7dcb-43e4-944c-5f31a15d873a";
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
    ssid = "Elite_Guest";
  };
  wifi-security = {
    auth-alg = "open";
    key-mgmt = "wpa-psk";
    psk = "$env_003ae82c_7dcb_43e4_944c_5f31a15d873a";
    psk-flags = "0";
  };
}
