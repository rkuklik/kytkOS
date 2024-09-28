{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp.servers.cssls = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.css = {
        __unkeyed-stylelint = "stylelint";
      };
      formatters.stylelint.command = lib.getExe pkgs.stylelint;
    };
  };
}
