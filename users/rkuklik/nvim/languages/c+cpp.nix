{
  pkgs,
  lib,
  ...
}:
let
  clang.__unkeyed-clang-format = "clang-format";
in
{
  programs.nixvim.plugins = {
    lsp.servers.clangd = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft = {
        c = clang;
        cpp = clang;
      };
      formatters.clang_format.command = lib.getExe' pkgs.clang-tools "clang-format";
    };
  };
}
