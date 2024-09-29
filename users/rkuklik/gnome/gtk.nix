{
  pkgs,
  config,
  ...
}: let
  extraConfig = {
    gtk-application-prefer-dark-theme = config.stylix.polarity == "dark";
    gtk-decoration-layout = ":minimize,maximize,close";
    gtk-enable-animations = true;
    gtk-primary-button-warps-slider = true;
  };
in {
  gtk = {
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = extraConfig;
    gtk4.extraConfig = extraConfig;
  };
}
