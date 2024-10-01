{
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
}
