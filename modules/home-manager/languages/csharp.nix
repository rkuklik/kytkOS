{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  inherit (config.xdg)
    dataHome
    configHome
    ;
  cfg = config.flowerbed.languages.csharp;
in
{
  options.flowerbed.languages.csharp = {
    enable = mkEnableOption "C#";
  };
  config = {
    home = {
      packages = mkIf cfg.enable [
        (
          with pkgs.dotnetCorePackages;
          combinePackages [
            sdk_8_0
            sdk_9_0
          ]
        )
      ];
      sessionVariables = {
        DOTNET_CLI_TELEMETRY_OPTOUT = 1;
        DOTNET_CLI_HOME = "${dataHome}/dotnet";
        OMNISHARPHOME = "${configHome}/omnisharp";
      };
    };
  };
}
