lib:
let
  mkConnection =
    {
      id,
      type,
      permissions ? null,
      uuid ? null,
    }:
    {
      inherit
        id
        type
        permissions
        uuid
        ;
    };
  mkWifi =
    {
      ssid,
      mode ? "infrastructure",
    }:
    {
      inherit
        ssid
        mode
        ;
    };
  mkProxy = { }: { };
  mkWifiSecurity =
    {
      key-mgmt,
      auth-alg ? null,
      psk ? null,
      psk-flags ? "0",
    }:
    {
      inherit
        key-mgmt
        auth-alg
        psk
        psk-flags
        ;
    };
  mk802-1x = null;
  mkSimpleWifi =
    {
      ssid,
      psk,
      uuid ? null,
    }:
    {
      connection = mkConnection {
        id = ssid;
        permissions = "user:rkuklik:;";
        type = "wifi";
        uuid = uuid;
      };
      ipv4 = {
        method = "auto";
      };
      ipv6 = {
        addr-gen-mode = "default";
        method = "auto";
      };
      wifi = mkWifi { inherit ssid; };
      wifi-security = mkWifiSecurity {
        auth-alg = "open";
        key-mgmt = "wpa-psk";
        psk = psk;
      };
      proxy = mkProxy { };
    };
in
{
  inherit
    mkConnection
    mkWifi
    mkWifiSecurity
    mkSimpleWifi
    mk802-1x
    ;
}
