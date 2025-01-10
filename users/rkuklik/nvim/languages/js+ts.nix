{
  pkgs,
  lib,
  ...
}:
let
  deno.__unkeyed-deno = "deno_fmt";
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
          javascript = deno;
          typescript = deno;
          javascriptreact = deno;
          typescriptreact = deno;
        };
        formatters.deno_fmt = {
          command = lib.getExe pkgs.deno;
          append_args = [
            "--unstable-component"
            "--unstable-sql"
            "--indent-width"
            "4"
          ];
        };
      };
    };
  };
}
