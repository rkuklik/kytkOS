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
  cfg = config.flowerbed.languages.tex;
in
{
  options.flowerbed.languages.tex = {
    enable = mkEnableOption "LaTex";
  };
  config = mkIf (cfg.enable) {
    home = {
      packages = [ pkgs.texliveFull ];
    };
  };
}
