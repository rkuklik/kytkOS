{
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
    stylix.targets.kde.enable = false;
  };
}
