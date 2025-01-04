{ pkgs, ... }:
let
  prettierd.__unkeyed-prettierd = "prettierd";
in
{
  programs.nixvim = {
    extraPackages = [ pkgs.typescript ];
    plugins = {
      lsp.servers.denols = {
        enable = true;
      };
      conform-nvim.settings = {
        formatters_by_ft = {
          javascript = prettierd;
          typescript = prettierd;
          javascriptreact = prettierd;
          typescriptreact = prettierd;
        };
      };
    };
  };
}
