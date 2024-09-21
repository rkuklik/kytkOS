{
  config,
  lib,
  hostname,
  ...
}: let
  inherit
    (lib)
    mkOption
    types
    ;
  regex = "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
  cfg = config.kytkos.net;
in {
  options.kytkos.net = {
    hostname = mkOption {
      description = "Machine name";
      default = hostname;
      type = types.strMatching regex;
    };
    domain = mkOption {
      description = "Machine domain";
      default = "kytkos.cz";
      example = "local";
      type = types.str;
    };
  };
  config.networking = {
    hostName = cfg.hostname;
    domain = cfg.domain;
  };
}
