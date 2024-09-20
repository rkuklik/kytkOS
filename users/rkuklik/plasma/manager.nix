{
  inputs,
  lib,
  os,
  ...
}: {
  imports = [inputs.plasma-manager.homeManagerModules.plasma-manager];
  config = lib.mkIf os.kytkos.desktop.plasma.enable {
    programs = {
      plasma.enable = true;
      plasma.overrideConfig = true;
    };
    stylix.targets.kde.enable = false;
  };
}
