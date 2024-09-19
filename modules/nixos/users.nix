{
  config,
  lib,
  flower,
  ...
}: let
  inherit
    (lib)
    types
    optional
    attrNames
    mkMerge
    mkOption
    mkEnableOption
    mkIf
    ;

  userOptions.options = {
    name = mkOption {
      type = types.passwdEntry types.str;
      description = "User's full name";
    };
    admin = mkEnableOption "Give user administrator priviledges";
    net = mkEnableOption "Allow user to change network configuration";
    home-manager = mkEnableOption "Manage home with home-manager";
  };

  cfg = config.kytkos.users;
  users = attrNames cfg;

  nixuser = name: let
    conf = cfg.${name};
  in {
    ${name} = {
      isNormalUser = true;
      description = conf.name;
      extraGroups =
        []
        ++ optional conf.admin "wheel"
        ++ optional conf.net "networkmanager";
    };
  };
  homeuser = name: {
    ${name} = mkIf cfg.${name}.home-manager {
      imports = flower.fs.include ../../users/${name};
    };
  };

  merger = f: mkMerge (map f users);
in {
  options.kytkos.users = mkOption {
    type = types.attrsOf (types.submodule userOptions);
    default = {};
  };

  config = {
    users.users = merger nixuser;
    home-manager.users = merger homeuser;
  };
}
