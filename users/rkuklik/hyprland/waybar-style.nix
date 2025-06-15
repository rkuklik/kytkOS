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
    "bright-yellow"
    "bright-green"
    "bright-cyan"
    "bright-blue"
    "bright-magenta"
  ];
  varbuilder = {
    define = { name, value }: "@define-color ${name} ${value};";
    native = { name, value }: "--${name}: ${value};";
  };
  kvbase = c: {
    name = c;
    value = h.${c};
  };
  colors = (map kvbase (base16 ++ named)) ++ [
    {
      name = "foreground";
      value = h.base06;
    }
    {
      name = "background";
      value = h.base00;
    }
  ];
  variables = concatMapStringsSep "\n" varbuilder.define colors;
  inherit (config.stylix)
    fonts
    opacity
    ;
  stylebase =
    # css
    ''
      ${variables}

      * {
        font-family: "${fonts.sansSerif.name}";
        font-size: ${toString fonts.sizes.desktop}pt;
      }
      window#waybar, tooltip {
        background: alpha(@base00, ${toString opacity.desktop});
      }
    '';
  externalcss = builtins.replaceStrings [ "var(--" ")" ] [ "@" "" ] (builtins.readFile ./waybar.css);
in
{
  programs.waybar = {
    enable = config.wayland.windowManager.hyprland.enable;
    style = concatStringsSep "\n\n" [
      stylebase
      externalcss
    ];
  };
  stylix.targets.waybar.enable = false;
  home.packages = with pkgs; [
    pulsemixer
    iwmenu
    bzmenu
  ];
}
