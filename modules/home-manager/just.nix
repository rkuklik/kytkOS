{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkPackageOption
    mkIf
    ;
  cfg = config.programs.just;
in {
  disabledModules = ["programs/just.nix"];
  options = {
    programs.just = {
      enable = mkEnableOption "Just";
      package = mkPackageOption pkgs "just" {};
    };
  };
  config = mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
