{os, ...}: let
  mod = "SUPER";
in {
  wayland.windowManager.hyprland = {
    enable = os.kytkos.desktop.hyprland.enable;
    settings = {
      monitor = ",preferred,auto,auto";

      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;
      };

      decoration = {
        shadow_offset = "0 5";
      };

      input = {
        numlock_by_default = true;
      };

      bind = [
        "${mod} ALT"
      ];
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
        "${mod} ALT, mouse:272, resizewindow"
      ];
    };
  };
}
