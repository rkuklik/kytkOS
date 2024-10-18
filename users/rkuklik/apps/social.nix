{pkgs, ...}: {
  home.packages = [
    pkgs.legcord
    pkgs.caprine
    pkgs.signal-desktop
  ];
}
