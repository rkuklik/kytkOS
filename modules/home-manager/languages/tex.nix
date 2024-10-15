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
  options.flowerbed.languages.tex = {
    enable = mkEnableOption "Latex";
  };
  config = mkIf (cfg.tex.enable) {
    home = {
      packages = [pkgs.texliveFull];
    };
  };
}
