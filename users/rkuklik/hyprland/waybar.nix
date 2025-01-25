{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    concatStringsSep
    concatMapStringsSep
    elemAt
    listToAttrs
    mod
    range
    toHexString
    ;
  h = config.lib.stylix.colors.withHashtag;
  base16 = map (num: "base0${toHexString num}") (range 0 15);
  named = [
    "red"
    "orange"
    "yellow"
    "green"
    "cyan"
    "blue"
    "magenta"
    "brown"
    "bright-red"
    "bright-orange"
    "bright-green"
    "bright-cyan"
    "bright-blue"
    "bright-magenta"
  ];
  csscolors = concatMapStringsSep "\n" (c: "@define-color ${c} ${h.${c}};") (base16 ++ named);
  inherit (config.stylix)
    fonts
    opacity
    ;
  styleconfig =
    # css
    ''
      @define-color foreground ${h.base06};
      @define-color background ${h.base00};
      * {
        font-family: "${fonts.sansSerif.name}";
        font-size: ${toString fonts.sizes.desktop}pt;
      }
      window#waybar, tooltip {
        background: alpha(@base00, ${toString opacity.desktop});
      }
    '';
  workspaceNumbers = (range 1 10);
  #workspaceIcons = [ "󰈹" "" "󰈙" "" " " "󱢇" "󰝚" "" "" "" ];
  #icon = index: elemAt workspaceIcons (index - 1);
  icon = index: toString (mod index 10);
in
{
  #home.packages = [ pkgs.fira-code ];
  programs.waybar = {
    enable = true || config.wayland.windowManager.hyprland.enable;
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
          "network"
          "clock"
          "battery"
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
          format = "{usage}% ";
        };
        memory = {
          format = "{}% ";
        };
        battery = {
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
    style = concatStringsSep "\n" [
      csscolors
      styleconfig
      (builtins.readFile ./waybar.css)
    ];
  };
  stylix.targets.waybar.enable = false;
}
