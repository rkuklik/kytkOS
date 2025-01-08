{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkOption
    mkEnableOption
    mkIf
    types
    ;
  cfg = config.flowerbed.languages.js-ts;
in
{
  options.flowerbed.languages.js-ts = {
    enable = mkEnableOption "JavaScript and TypeScript";
    runtime = mkOption {
      description = "Runtime to use";
      type = types.enum [
        "deno"
        "nodejs"
      ];
      default = "deno";
    };
  };
  config = mkIf cfg.enable {
    home = {
      packages = [ pkgs.${cfg.runtime} ];
    };
  };
}
