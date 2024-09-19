{
  lib,
  os,
  ...
}: {
  config = {
    programs.home-manager.enable = true;
    home.stateVersion = lib.mkDefault os.system.stateVersion;
  };
}
