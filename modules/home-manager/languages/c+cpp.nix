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
  cfg = config.flowerbed.languages.c-cpp;
in
{
  options.flowerbed.languages.c-cpp = {
    enable = mkEnableOption "C and C++";
  };
  config = mkIf cfg.enable {
    home = {
      packages = [ pkgs.gcc ];
    };
  };
}
