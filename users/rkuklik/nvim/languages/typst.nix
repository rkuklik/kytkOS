{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    filetype.extension.typ = "typst";
    plugins = {
      lsp.servers.tinymist = {
        enable = true;
      };
      conform-nvim.settings = {
        formatters_by_ft.typst = {
          __unkeyed-typstyle = "typstyle";
        };
        formatters.typstyle.command = lib.getExe pkgs.typstyle;
      };
    };
  };
}
