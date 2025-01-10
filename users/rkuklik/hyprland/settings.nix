{
  os,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    getExe
    ;

  mod = "SUPER";
in
{
  wayland.windowManager.hyprland = {
    enable = os.kytkos.desktop.hyprland.enable;
    settings = {
      monitor = ",preferred,auto,auto";
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
      };
      decoration = {
        shadow = {
          offset = "0 5";
        };
      };
      input = {
        numlock_by_default = true;
        natural_scroll = true;
      };
      bind = [
        "${mod}, Return, exec, ${getExe config.programs.alacritty.package}"
        "${mod}, q, killactive"
      ];
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
        "${mod} ALT, mouse:272, resizewindow"
      ];
    };
  };
}
