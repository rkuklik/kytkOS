{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.flowerbed.languages.go;
in
{
  options.flowerbed.languages.go = {
    enable = mkEnableOption "Go";
  };
  config = {
    home = {
      packages = mkIf cfg.enable [ cfg.programs.go.package ];
      sessionVariables = {
        GOPATH = "${config.xdg.dataHome}/go";
      };
    };
  };
}
