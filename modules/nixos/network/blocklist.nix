{
  config,
  lib,
  ...
}:
let
  cfg = config.kytkos.net.blacklist;
  inherit (lib)
    concatMap
    mkIf
    mkEnableOption
    ;
in
{
  options.kytkos.net.blacklist = {
    enable = mkEnableOption "Base blocklist (malware + adware)" // {
      default = true;
    };
    fakenews = mkEnableOption "Also block fakenews sites";
    gambling = mkEnableOption "Also block gambling sites";
    porn = mkEnableOption "Also block porn sites";
    social = mkEnableOption "Also block social sites";
  };

  config = {
    warnings =
      with cfg;
      if ((fakenews || gambling || porn || social) -> enable) then
        [ ]
      else
        [ "Additional blacklists supported if base blocklist is enabled" ];
    networking.stevenblack = mkIf cfg.enable {
      enable = true;
      block = concatMap (name: if cfg.${name} then [ name ] else [ ]) [
        "fakenews"
        "gambling"
        "porn"
        "social"
      ];
    };
  };
}
