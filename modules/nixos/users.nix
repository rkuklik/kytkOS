{
  config,
  pkgs,
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
    password = mkOption {
      description = "User's password";
      type = types.nullOr types.str;
      default = null;
    };
    home-manager = {
      enable = mkEnableOption "Manage home with home-manager";
      settings = mkOption {
        description = "Config options to pass in";
        type = types.anything;
      };
    };
  };

  cfg = config.kytkos.users;
  users = attrNames cfg;

  nixuser = name: let
    conf = cfg.${name};
  in {
    ${name} = {
      isNormalUser = true;
      description = conf.name;
      hashedPassword = mkIf (conf.password != null) (conf.password);
      extraGroups =
        []
        ++ optional conf.admin "wheel"
        ++ optional conf.net "networkmanager";
    };
  };
  homeuser = name: let
    conf = cfg.${name}.home-manager;
  in {
    ${name} = mkIf conf.enable (
      mkMerge [
        {imports = flower.fs.include ../../users/${name};}
        conf.settings
      ]
    );
  };

  merger = f: mkMerge (map f users);
in {
  options.kytkos.users = mkOption {
    type = types.attrsOf (types.submodule userOptions);
    default = {};
  };

  config = {
    users = {
      mutableUsers = false;
      defaultUserShell = pkgs.zsh;
      users = merger nixuser;
    };
    home-manager.users = merger homeuser;
  };
}
