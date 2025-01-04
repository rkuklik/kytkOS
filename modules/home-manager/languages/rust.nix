{
  os,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    optionals
    ;
  inherit (config.xdg) dataHome;
  cfg = config.flowerbed.languages.rust;
  latest = pkgs.rust-bin.stable.latest;
  arch = os.nixpkgs.hostPlatform.linuxArch;
  bundle = latest.default.override {
    extensions = optionals cfg.sources [ "rust-src" ];
    targets = [
      "${arch}-unknown-linux-musl"
      "wasm32-unknown-unknown"
      "wasm32-wasip1"
    ];
  };
in
{
  options.flowerbed.languages.rust = {
    enable = mkEnableOption "Rust";
    sources = mkEnableOption "Rust source code";
  };
  config = mkIf (cfg.enable) {
    flowerbed.languages.c-cpp.enable = true;
    home = {
      packages = [ bundle ];
      sessionVariables = {
        CARGO_HOME = "${dataHome}/cargo";
        RUSTUP_HOME = "${dataHome}/rustup";
        RUST_SRC_PATH = mkIf cfg.sources "${latest.rust-src}";
      };
    };
  };
}
