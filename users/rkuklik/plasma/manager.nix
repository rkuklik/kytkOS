{
  pkgs,
  lib,
  os,
  ...
}: {
  config = lib.mkIf os.kytkos.desktop.plasma.enable {
    programs.plasma = {
      enable = true;
      immutableByDefault = true;
      overrideConfig = false;
    };
    programs.firefox.nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
  };
}
