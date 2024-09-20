{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp.servers.marksman = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.markdown = {
        __unkeyed-prettierd = "prettierd";
      };
      formatters.prettierd.command = lib.getExe pkgs.prettierd;
    };
  };
}
