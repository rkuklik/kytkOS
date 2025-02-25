{
  pkgs,
  ...
}:
{
  documentation = {
    enable = true;
    dev.enable = true;
    info.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    nixos = {
      enable = true;
      #includeAllModules = true;
    };
  };
  environment.systemPackages = [
    pkgs.man-pages
    pkgs.man-pages-posix
  ];
}
