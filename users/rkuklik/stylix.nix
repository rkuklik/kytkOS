{
  pkgs,
  ...
}:
let
  colorscheme = "rose-pine";
  polarity = "dark";
in
{
  stylix = {
    enable = true;
    polarity = polarity;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}.yaml";
    image = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Mountain/contents/images_dark/5120x2880.png";
    fonts = {
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sizes = {
        terminal = 14;
        desktop = 10;
        applications = 10;
      };
    };
    cursor = {
      package = pkgs.kdePackages.breeze;
      name = "breeze_cursors";
      size = 24;
    };
    opacity = {
      terminal = 0.8;
    };
    targets.qt = {
      enable = false;
    };
  };
}
