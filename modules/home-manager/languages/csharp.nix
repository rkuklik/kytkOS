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
  cfg = config.flowerbed.languages.csharp;
in
{
  options.flowerbed.languages.csharp = {
    enable = mkEnableOption "C#";
  };
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = false;
        message = "todo";
      }
    ];
  };
}
