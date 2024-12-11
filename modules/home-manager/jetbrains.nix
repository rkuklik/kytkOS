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
  inherit (pkgs) jetbrains;
  cfg = config.flowerbed.jetbrains;
  rust-rover = mkIf (cfg.rust-rover) {
    home.packages = [
      jetbrains.rust-rover
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
    home.packages = [jetbrains.pycharm-community];
    flowerbed.languages.python = {
      enable = true;
    };
  };
  android-studio = mkIf (cfg.android-studio) {
    home.packages = [pkgs.android-studio];
  };
in {
  options.flowerbed.jetbrains = {
    rust-rover = mkEnableOption "RustRover";
    rider = mkEnableOption "Rider";
    pycharm-community = mkEnableOption "PyCharm CE";
    android-studio = mkEnableOption "Android Studio";
  };
  config = mkMerge [
    rust-rover
    rider
    pycharm-community
    android-studio
  ];
}
