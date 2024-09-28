{
  lib,
  pkgs,
  ...
}: let
  prettierd.__unkeyed-prettierd = "prettierd";
in {
  programs.nixvim.plugins = {
    lsp.servers.jsonls = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft = {
        json = prettierd;
        json5 = prettierd;
      };
    };
  };
}
