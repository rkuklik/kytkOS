{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers.taplo = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.toml = {
        __unkeyed-taplo = "taplo";
      };
      formatters.taplo.command = lib.getExe pkgs.taplo;
    };
  };
}
