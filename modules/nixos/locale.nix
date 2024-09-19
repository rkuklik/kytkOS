{
  config,
  lib,
  ...
}: let
  en = "en_US.UTF-8";
  cs = "cs_CZ.UTF-8";
  zone = "Europe/Prague";
  cfg = config.kytkos.localization;
  inherit
    (lib)
    types
    mkOption
    mkDefault
    ;
in {
  options.kytkos.localization = {
    zone = mkOption {
      default = zone;
      type = types.str;
      description = "Time zone";
    };
    locale = mkOption {
      default = en;
      type = types.str;
      description = "Base language";
    };
    localeExtra = mkOption {
      default = cs;
      type = types.str;
      description = "Additional language for things like dates and currency";
    };
  };

  config = {
    time.timeZone = cfg.zone;
    i18n = {
      defaultLocale = cfg.locale;
      extraLocaleSettings = let
        extra = mkDefault cfg.localeExtra;
      in {
        LC_ADDRESS = extra;
        LC_IDENTIFICATION = extra;
        LC_MEASUREMENT = extra;
        LC_MONETARY = extra;
        LC_NAME = extra;
        LC_NUMERIC = extra;
        LC_PAPER = extra;
        LC_TELEPHONE = extra;
        LC_TIME = extra;
      };
    };
  };
}
