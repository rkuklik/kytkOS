let
  inherit
    (builtins)
    replaceStrings
    ;

  mkEnv = str: "$env_${replaceStrings ["-"] ["_"] str}";

  mkSimpleWifi = {
    name,
    uuid,
    password ? true,
    ssid ? name,
  }: {
    connection = {
      id = name;
      type = "wifi";
      uuid = uuid;
      permissions = "user:rkuklik:;";
    };
    ipv4 = {
      method = "auto";
    };
    ipv6 = {
      method = "auto";
      addr-gen-mode = "default";
    };
    wifi = {
      inherit ssid;
      mode = "infrastructure";
    };
    wifi-security =
      if password
      then {
        auth-alg = "open";
        key-mgmt = "wpa-psk";
        psk = mkEnv uuid;
        psk-flags = "0";
      }
      else {};
    proxy = {};
  };

  # remove $env_f5db0403_e889_44bf_aee3_0a09f85cae32
  eduroamNm =
    (mkSimpleWifi {
      name = "eduroam";
      uuid = "a3ab6936-aa8e-47f4-87e5-253b8ca9a17c";
      password = false;
    })
    // {
      wifi-security = {
        key-mgmt = "wpa-eap";
        group = "ccmp;tkip;";
        pairwise = "ccmp;";
        proto = "rsn;";
      };
      "802-1x" = {
        altsubject-matches = "DNS:radius1.eduroam.cuni.cz;DNS:radius2.eduroam.cuni.cz;";
        # SHA-1 is not supported
        domain-suffix-match = "cuni.cz";
        ca-cert = "$eduroam_cuni";
        eap = "peap;";
        identity = "96388105@cuni.cz";
        password = "$env_a3ab6936_aa8e_47f4_87e5_253b8ca9a17c";
        password-flags = "0";
        phase2-auth = "mschapv2";
      };
    };
  eduroamIwd = {
    name = "eduroam";
    type = "8021x";
    Security = {
      EAP-Method = "PEAP";
      EAP-Identity = "anonymous@cuni.cz";
      #EAP-PEAP-CACert = "$eduroam_cuni";
      #EAP-PEAP-ServerDomainMask = "radius1.eduroam.cuni.cz";
      EAP-PEAP-Phase2-Method = "MSCHAPV2";
      EAP-PEAP-Phase2-Identity = "96388105@cuni.cz";
      EAP-PEAP-Phase2-Password = "$env_a3ab6936_aa8e_47f4_87e5_253b8ca9a17c";
    };
    Settings = {
      AutoConnect = true;
    };
  };
  vpn = {
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
  };
  securedWiFi =
    map
    mkSimpleWifi
    [
      {
        name = "WIFIucitel";
        uuid = "a8f7e1a2-3d7d-4339-97fd-533e3647e0a8";
      }
      {
        name = "labnet";
        uuid = "c94995b4-be63-4820-876b-b224426c4a32";
      }
      {
        name = "UPC9520399";
        uuid = "fb6e8e1a-539d-4d05-85e3-b8933f8b50b9";
      }
      {
        name = "Coalflower";
        uuid = "fd08818d-1c15-4b9d-b798-f9cdc74fe4f9";
      }
      {
        name = "Poliklinika5GHz-Zdarma";
        uuid = "78079426-d003-4920-8228-563be0930cdf";
      }
      {
        name = "skolskykomplex.cz";
        uuid = "aaae4b9b-2f6f-48d7-891a-b8901aa22d4d";
      }
      {
        name = "T-nvtXWq";
        uuid = "16e049c8-ac2e-4807-a0eb-7474853d2e10";
      }
      {
        name = "VSCHT-Bestvina";
        uuid = "cf09d16d-5856-4ed5-9d21-2471562070e4";
      }
      {
        name = "STARNET_61af";
        uuid = "7be4123e-298a-4161-a3a8-251014ff1765";
      }
      {
        name = "ZO!123";
        uuid = "d8e632a6-a865-47dd-a890-8400d48459e1";
      }
      {
        name = "Internet_60";
        uuid = "2704f0fd-b17b-472c-9b49-a0f2e4f19d7e";
      }
      {
        name = "Matthew’s - iPhone 13";
        uuid = "50a76172-429e-45be-aa32-2e4116128e09";
        ssid = "77;97;116;116;104;101;119;226;128;153;115;32;45;32;105;80;104;111;110;101;32;49;51;";
      }
      {
        name = "Matthew’s - iPhone 12 mini";
        uuid = "ce4a9629-624c-4187-bcaf-5b8002131438";
        ssid = "77;97;116;116;104;101;119;226;128;153;115;32;45;32;105;80;104;111;110;101;32;49;50;32;109;105;110;105;";
      }
      {
        name = "Internet_18";
        uuid = "3f4085c7-9486-4564-a242-d5e42fd33b69";
      }
      {
        name = "Pixel";
        uuid = "5b2fb06c-5c92-4a57-bb49-de8e0f7f4f08";
      }
      {
        name = "Internet";
        uuid = "7f2a952b-fc45-49d5-bd66-ba3d70534a81";
      }
      {
        name = "Mohamed - iPhone";
        uuid = "7578a2ac-ed61-4709-850c-24036132107b";
      }
      {
        name = "Poliklinika2GHz-Zdarma";
        uuid = "3748ee52-5728-475c-93f3-14edbdaa7678";
      }
      {
        name = "GopasWifi";
        uuid = "9221b1db-afcf-4fc9-854d-823f1a753d94";
      }
      {
        name = "Galaxy XCover 5 DF4F";
        uuid = "1c5fdcf6-bd5e-4da4-9e5b-ebcd8101ca6a";
      }
      {
        name = "Elite_Guest";
        uuid = "003ae82c-7dcb-43e4-944c-5f31a15d873a";
      }
      {
        name = "AndroidAP";
        uuid = "a2670714-175f-43ff-83ee-41d0af9f622d";
      }
      {
        name = "1,2,3 Zo";
        uuid = "54fbb0bb-efd4-40d8-901d-f7aa0cd6a717";
      }
      {
        name = "exp";
        uuid = "7283f40a-9a6a-4656-95e2-989961a35647";
      }
      {
        name = "A94E59";
        uuid = "0a00ec7d-e2d4-4555-b462-fd56fcb6ebfb";
      }
    ];
in {
  nm = securedWiFi ++ [eduroamNm vpn];
  iwd = [eduroamIwd];
}
