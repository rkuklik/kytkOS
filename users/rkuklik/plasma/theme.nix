{
  pkgs,
  ...
}:
let
  name = "arstotzka";
  kwinrc."org.kde.kdecoration3" = {
    library = name;
    theme = "Arstotzka";
    BorderSize = "Tiny";
    BorderSizeAuto = false;
  };
in
{
  home.packages = [
    pkgs.arstotzka
    #pkgs.kdePackages.krohnkite
  ];
  programs.plasma = {
    configFile = {
      inherit kwinrc;
    };
  };
  stylix.targets.kde.decorations = name;
}
