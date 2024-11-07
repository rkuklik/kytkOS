{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    listToAttrs
    getExe
    mkIf
    mod
    range
    ;
  inherit (builtins) toString;

  desktopMapper = name: base:
    listToAttrs
    (map (num: {
        name = "${name} ${toString num}";
        value = "${base}${toString (mod num 10)}";
      })
      (range 1 10));
  screenMapper = name: base:
    listToAttrs
    (map (num: {
        name = "${name} ${toString (num - 1)}";
        value = "${base}${toString num}";
      })
      (range 1 8));

  inherit
    (config.programs)
    alacritty
    wezterm
    ;
  alacrittyLauncher = pkgs.writeShellApplication {
    name = "Alacritty";
    runtimeInputs = [alacritty.package];
    text = "alacritty msg create-window || alacritty";
  };
in {
  programs.plasma = {
    shortcuts = {
      ksmserver = {
        "Lock Session" = "Ctrl+Alt+L";
      };
      kwin =
        {
          "Window Fullscreen" = "Meta+Shift+F";
          "Window Maximize" = "Meta+F";
          "Window Close" = "Meta+Q";
          "Kill Window" = "Meta+Ctrl+Esc";
          "MoveMouseToCenter" = "Meta+C";
          "Window Move Center" = "Meta+Shift+C";
          "Overview" = ["Meta" "Meta+W"];
          "Window No Border" = "Meta+X";

          "Window Quick Tile Bottom" = "Meta+Alt+Down";
          "Window Quick Tile Left" = "Meta+Alt+Left";
          "Window Quick Tile Right" = "Meta+Alt+Right";
          "Window Quick Tile Top" = "Meta+Alt+Up";

          "Switch Window Down" = "Meta+Down";
          "Switch Window Left" = "Meta+Left";
          "Switch Window Right" = "Meta+Right";
          "Switch Window Up" = "Meta+Up";

          "Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
          "Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
          "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
          "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        }
        // (desktopMapper "Switch to Desktop" "Meta+")
        // (desktopMapper "Window to Desktop" "Meta+Ctrl+")
        // (screenMapper "Switch to Screen" "Meta+Alt+")
        // (screenMapper "Window to Screen" "Meta+Alt+Ctrl+");
    };
    hotkeys.commands = {
      alacritty = mkIf alacritty.enable {
        command = getExe alacrittyLauncher;
        key = "Meta+Shift+Return";
        comment = "Launch Alacritty";
      };
      wezterm = mkIf wezterm.enable {
        command = getExe wezterm.package;
        key = "Meta+Return";
        comment = "Launch WezTerm";
      };
      kcalc = {
        command = getExe pkgs.kdePackages.kcalc;
        key = "Calculator";
        comment = "Launch KCalc";
      };
    };
  };
}
