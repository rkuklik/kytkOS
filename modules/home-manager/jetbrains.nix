{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkMerge
    mkIf
    ;
  cfg = config.flowerbed.jetbrains;
  rust-rover = mkIf (cfg.rust-rover) {
    home.packages = [pkgs.jetbrains.rust-rover];
    flowerbed.languages.rust = {
      enable = true;
      sources = true;
    };
  };
  pycharm-community = mkIf (cfg.pycharm-community) {
    home.packages = [pkgs.jetbrains.pycharm-community];
    flowerbed.languages.python = {
      enable = true;
    };
  };
in {
  options.flowerbed.jetbrains = {
    rust-rover = mkEnableOption "RustRover";
    pycharm-community = mkEnableOption "PyCharm CE";
  };
  config = mkMerge [
    rust-rover
    pycharm-community
  ];
}
