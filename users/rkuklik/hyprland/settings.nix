{
  os,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    flatten
    getExe
    mod
    mapAttrsToList
    range
    ;

  workspaces = range 1 10;
  numeric = [
    (id: "${keys.main}, ${toString (mod id 10)}, workspace, ${toString id}")
    (id: "${keys.main} ${keys.ctrl}, ${toString (mod id 10)}, movetoworkspace, ${toString id}")
  ];
  mkFocusBind = _: def: map (key: "${keys.main}, ${key}, movefocus, ${def.hypr}") def.keys;
  mkSwapBind =
    _: def: map (key: "${keys.main} ${keys.alt}, ${key}, swapwindow, ${def.hypr}") def.keys;
  direction = {
    left = {
      hypr = "l";
      keys = [
        "left"
        "h"
      ];
    };
    right = {
      hypr = "r";
      keys = [
        "right"
        "l"
      ];
    };
    up = {
      hypr = "u";
      keys = [
        "up"
        "k"
      ];
    };
    down = {
      hypr = "d";
      keys = [
        "down"
        "j"
      ];
    };
  };

  keys = {
    shift = "SHIFT";
    main = "SUPER";
    ctrl = "CTRL";
    alt = "ALT";
  };

  bind = flatten [
    [
      "${keys.main}, Return, exec, ${getExe config.programs.alacritty.package}"
      "${keys.main}, q, killactive"
      "${keys.main}, f, fullscreen, 1"
      "${keys.main} ${keys.shift}, f, fullscreen, 0"
      "${keys.main} ${keys.shift}, c, centerwindow"
    ]
    (map (key: "${keys.main} ${keys.ctrl}, ${key}, workspace, -1") direction.left.keys)
    (map (key: "${keys.main} ${keys.ctrl}, ${key}, workspace, +1") direction.right.keys)
    (map (
      key: "${keys.main} ${keys.ctrl} ${keys.shift}, ${key}, movetoworkspace, -1"
    ) direction.left.keys)
    (map (
      key: "${keys.main} ${keys.ctrl} ${keys.shift}, ${key}, movetoworkspace, +1"
    ) direction.right.keys)
    (map (f: map f workspaces) numeric)
    (mapAttrsToList mkFocusBind direction)
    (mapAttrsToList mkSwapBind direction)
  ];
  bindm = [
    "${keys.main}, mouse:272, movewindow"
    "${keys.main}, mouse:273, resizewindow"
    "${keys.main} ${keys.alt}, mouse:272, resizewindow"
  ];
  workspace = map (id: "${toString id}, persistent:true") workspaces;
in
{
  wayland.windowManager.hyprland = {
    enable = os.kytkos.desktop.hyprland.enable;
    settings = {
      monitor = ",preferred,auto,auto";
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
      };
      gestures = {
        workspace_swipe = true;
      };
      decoration = {
        shadow = {
          offset = "0 5";
        };
      };
      input = {
        numlock_by_default = true;
        touchpad = {
          natural_scroll = true;
        };
      };
      inherit
        bind
        bindm
        workspace
        ;
    };
  };
}
