{
  pkgs,
  ...
}:
let
  kwinrc."org.kde.kdecoration2" = {
    library = "arstotzka";
    theme = "Arstotzka";
    BorderSize = "Tiny";
    BorderSizeAuto = false;
  };
in
{
  config = {
    home.packages = [
      pkgs.arstotzka
      #pkgs.kdePackages.krohnkite
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
