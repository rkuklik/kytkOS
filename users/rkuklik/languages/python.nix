{pkgs, ...}: {
  home.packages = [
    pkgs.python3
    pkgs.jetbrains.pycharm-community
  ];
}
