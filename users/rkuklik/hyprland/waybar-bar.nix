{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    elemAt
    listToAttrs
    mod
    range
    ;
  workspaceNumbers = (range 1 10);
  #workspaceIcons = [ "󰈹" "" "󰈙" "" " " "󱢇" "󰝚" "" "" "" ];
  #icon = index: elemAt workspaceIcons (index - 1);
  icon = index: toString (mod index 10);
in
{
  programs.waybar = {
    enable = config.wayland.windowManager.hyprland.enable;
    settings = {
      hyprland-topbar = {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [ ];
        modules-right = [
          "tray"
          "pulseaudio"
          "cpu"
          "memory"
          "bluetooth"
          "network"
          "battery"
          "clock"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = listToAttrs (
            map (i: {
              name = toString i;
              value = icon i;
            }) workspaceNumbers
          );
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        tray = {
          spacing = 10;
        };
        clock = {
          interval = 1;
          format = "  {:%a %d %b   %H:%M:%S}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        cpu = {
          interval = 3;
          format = "{usage}% ";
        };
        memory = {
          interval = 3;
          format = "{}% ";
        };
        battery = {
          interval = 1;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          on-click = "bzmenu --launcher walker --spaces 3";
        };
        network = {
          format = "  Wired {icon}";
          format-disconnected = " Unwired";
          format-icons = {
            wifi = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
          };
          on-click = "iwmenu --launcher walker --spaces 3";
        };
        pulseaudio = {
          format = "{volume}% {icon} / {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "{volume}% ";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            default-muted = "󰝟";
          };
          reverse-scrolling = true;
          on-click = "pulsemixer";
        };
      };
    };
  };
  stylix.targets.waybar.enable = false;
  home.packages = with pkgs; [
    pulsemixer
    iwmenu
    bzmenu
  ];
}
