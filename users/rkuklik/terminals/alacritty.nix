{config, ...}: let
  cfg = config.flowerbed.terminal;
in {
  programs.alacritty.enable = cfg.enable;
}
