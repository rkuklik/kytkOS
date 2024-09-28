{pkgs, ...}: let
  prettierd.__unkeyed-prettierd = "prettierd";
in {
  programs.nixvim = {
    extraPackages = [pkgs.typescript];
    plugins = {
      typescript-tools.enable = true;
      lsp.servers.clangd = {
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
