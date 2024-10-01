{
  connection = {
    id = "Internet_60";
    permissions = "user:rkuklik:;";
    type = "wifi";
    uuid = "2704f0fd-b17b-472c-9b49-a0f2e4f19d7e";
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
    ssid = "Internet_60";
  };
  wifi-security = {
    key-mgmt = "wpa-psk";
    psk = "$env_2704f0fd_b17b_472c_9b49_a0f2e4f19d7e";
    psk-flags = "0";
  };
}
