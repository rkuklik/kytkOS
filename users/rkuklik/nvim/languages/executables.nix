{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    conform-nvim.settings = {
      formatters.prettierd.command = lib.getExe pkgs.prettierd;
    };
  };
}
