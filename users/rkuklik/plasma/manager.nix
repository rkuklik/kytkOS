{
  inputs,
  lib,
  os,
  ...
}: {
  imports = [inputs.plasma-manager.homeManagerModules.plasma-manager];
  config = lib.mkIf os.kytkos.desktop.plasma.enable {
    programs.plasma = {
      enable = true;
      overrideConfig = false;
    };
    stylix.targets.kde.enable = false;
  };
}
