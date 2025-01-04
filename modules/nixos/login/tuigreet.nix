{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    concatStringsSep
    mkEnableOption
    mkOption
    mkIf
    optional
    optionals
    types
    ;
  cfg = config.kytkos.login.tuigreet;
in
{
  options.kytkos.login.tuigreet = {
    enable = mkEnableOption "Use tuigreet as login manager";
    vt = mkOption {
      description = "What vt to use";
      type = types.int;
      default = 2;
    };
    time = mkEnableOption "Display current time and date" // {
      default = true;
    };
    menu = mkEnableOption "Allow graphical selection for users" // {
      default = true;
    };
    remember = mkEnableOption "Remember last sesstion" // {
      default = true;
    };
    greeting = mkOption {
      description = "Show host's issue file";
      type = types.nullOr types.str;
      default = "Welcome to kytkOS";
    };
    command = mkOption {
      description = "Command to run";
      type = types.nullOr (types.either types.path types.str);
      default = null;
    };
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      vt = cfg.vt;
      settings = {
        default_session = {
          command = concatStringsSep " " (
            [ "${pkgs.greetd.tuigreet}/bin/tuigreet" ]
            ++ optional cfg.time "--time"
            ++ optional cfg.menu "--user-menu"
            ++ optionals cfg.remember [
              "--remember"
              "--remember-user-session"
            ]
            ++ optionals (cfg.greeting != null) [
              "--greeting"
              ''"${cfg.greeting}"''
            ]
            ++ optionals (cfg.command != null) [
              "--cmd"
              ''"${cfg.command}"''
            ]
          );
          user = "greeter";
        };
      };
    };
  };
}
