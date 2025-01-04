{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    filterAttrsRecursive
    listToAttrs
    mkOption
    types
    ;

  inherit (config.kytkos.net) connections;

  named = profile: {
    name = profile.connection.id;
    value = filterAttrsRecursive (name: value: value != null) profile;
  };

  mkType =
    mandatory:
    types.listOf (
      types.submodule {
        freeformType = (pkgs.formats.ini { }).type;
        options = mandatory;
      }
    );
  strOpt = mkOption { type = types.str; };

  data = import ../../../data/networks.nix;
in
{
  options.kytkos.net = {
    connections = mkOption {
      type = mkType {
        connection.id = strOpt;
      };
      default = data.nm;
    };
    iwd = mkOption {
      type = mkType {
        name = strOpt;
        type = strOpt;
      };
      default = data.iwd;
    };
  };
  config = {
    networking.networkmanager.ensureProfiles.profiles = listToAttrs (map named connections);
  };
}
