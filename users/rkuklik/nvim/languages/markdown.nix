{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    lsp.servers.marksman = {
      enable = true;
    };
    markdown-preview = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.markdown = {
        __unkeyed-prettierd = "prettierd";
      };
    };
    lint = {
      lintersByFt.markdown = ["markdownlint"];
      linters.markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
    };
  };
}
