{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkPackageOption
    mkIf
    ;
  inherit (config.xdg)
    dataHome
    configHome
    ;
  cfg = config.flowerbed.languages.java;
in
{
  options.flowerbed.languages.java = {
    enable = mkEnableOption "Java";
    package = mkPackageOption pkgs "jdk" { };
  };
  config = {
    home = {
      packages = mkIf cfg.enable [ cfg.package ];
      sessionVariables = {
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configHome}/java";
        JAVA_HOME = mkIf cfg.enable "${cfg.package}/lib/openjdk";
        GRADLE_USER_HOME = "${dataHome}/gradle";
      };
    };
  };
}
