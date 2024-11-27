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
    home.packages = [
      pkgs.jetbrains.rust-rover
      pkgs.cargo-expand
    ];
    flowerbed.languages.rust = {
      enable = true;
      sources = true;
    };
  };
  rider = mkIf (cfg.rider) {
    home.packages = [pkgs.jetbrains.rider];
    flowerbed.languages.csharp = {
      #enable = true;
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
    rider = mkEnableOption "Rider";
    pycharm-community = mkEnableOption "PyCharm CE";
  };
  config = mkMerge [
    rust-rover
    rider
    pycharm-community
  ];
}
