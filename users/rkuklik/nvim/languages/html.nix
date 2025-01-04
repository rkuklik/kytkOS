{
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers = {
      html = {
        enable = true;
      };
      superhtml = {
        enable = true;
        package = pkgs.superhtml;
      };
    };
    conform-nvim.settings = {
      formatters_by_ft.html = {
        __unkeyed-superhtml = "superhtml";
      };
      formatters.superhtml.command = lib.getExe pkgs.superhtml;
    };
  };
}
