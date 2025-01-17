{
  pkgs,
  ...
}:
{
  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "-L" ];
    };
    fd = {
      enable = true;
      hidden = true;
    };
    just = {
      enable = true;
    };
    eza = {
      enable = true;
      git = true;
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batman
        batpipe
        batwatch
        batdiff
      ];
    };
    htop = {
      enable = true;
    };
    bottom = {
      enable = true;
    };
  };
  home.packages = [ pkgs.rustcodex ];
}
