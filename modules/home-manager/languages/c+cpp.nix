{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.flowerbed.languages;
in {
  options.flowerbed.languages.c-cpp = {
    enable = mkEnableOption "C and C++";
  };
  config = mkIf (cfg.c-cpp.enable) {
    home = {
      packages = [pkgs.gcc];
    };
  };
}
