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
    optionals
    ;
  inherit (config.xdg) dataHome;
  cfg = config.flowerbed.languages;
in {
  options.flowerbed.languages.rust = {
    enable = mkEnableOption "Rust";
    sources = mkEnableOption "Rust source code";
  };
  config = mkIf (cfg.rust.enable) {
    flowerbed.languages.c-cpp.enable = true;
    home = {
      packages = with pkgs;
        [
          rustc
          cargo
          clippy
          rustfmt
        ]
        ++ optionals cfg.rust.sources [
          rustPlatform.rustcSrc
          rustPlatform.rustLibSrc
        ];
      sessionVariables = {
        CARGO_HOME = "${dataHome}/cargo";
        RUSTUP_HOME = "${dataHome}/rustup";
        RUST_SRC_PATH = mkIf cfg.rust.sources "${pkgs.rustPlatform.rustLibSrc}";
      };
    };
  };
}
