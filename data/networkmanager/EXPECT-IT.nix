{
  connection = {
    id = "EXPECT-IT";
    type = "vpn";
    uuid = "8baccb80-b2be-4f5f-a4a9-33a2f74faba9";
  };
  ipv4 = {
    method = "auto";
    never-default = "true";
  };
  ipv6 = {
    addr-gen-mode = "stable-privacy";
    method = "disabled";
  };
  proxy = {};
  vpn = {
    auth = "SHA1";
    ca = "/home/rkuklik/.config/sops-nix/secrets/vpn/expect-it/ca.pem";
    cert = "/home/rkuklik/.config/sops-nix/secrets/vpn/expect-it/cert.pem";
    cert-pass-flags = "1";
    connection-type = "password-tls";
    data-ciphers = "AES-256-GCM:AES-128-GCM:AES-256-CBC";
    dev = "tun";
    key = "/home/rkuklik/.config/sops-nix/secrets/vpn/expect-it/key.pem";
    password = "$env_8baccb80_b2be_4f5f_a4a9_33a2f74faba9";
    password-flags = "0";
    remote = "84.42.196.50:10443:tcp";
    remote-cert-tls = "server";
    service-type = "org.freedesktop.NetworkManager.openvpn";
    ta = "/home/rkuklik/.local/share/nm/expect-it/tls-auth.pem";
    ta-dir = "1";
    username = "rkuklik";
    verify-x509-name = "name:vpn.expect-it.cz";
  };
}
