{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers = {
      nil_ls.enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.nix = {
        __unkeyed-nixfmt = "nixfmt";
      };
      formatters = {
        nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
      };
    };
  };
}
