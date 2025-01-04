{ pkgs, ... }:
let
  # HACK: lookAndFeelDefaults didn't set this
  kwinrc."org.kde.kdecoration2" = {
    library = "arstotzka";
    theme = "Arstotzka";
    BorderSize = "Tiny";
    BorderSizeAuto = false;
  };
in
# Contains a wallpaper package, a colorscheme file, and a look and feel
# package which depends on both.
{
  config = {
    home.packages = [
      pkgs.arstotzka
    ];
    programs.plasma = {
      configFile = {
        kded5rc.Module-gtkconfig.autoload = {
          immutable = true;
          value = false;
        };
        inherit kwinrc;
      };
    };
  };
}
