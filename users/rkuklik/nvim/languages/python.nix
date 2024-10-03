{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) listToAttrs;
  names = [
    "ruff_fix"
    "ruff_format"
    "ruff_organize_imports"
  ];
  unkeyed = listToAttrs (map (name: {
      name = "__unkeyed-${name}";
      value = name;
    })
    names);
  ruff = lib.getExe pkgs.ruff;
  formatters = listToAttrs (map (name: {
      inherit name;
      value.command = ruff;
    })
    names);
in {
  programs.nixvim.plugins = {
    lsp.servers.pyright = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.python = unkeyed;
      inherit formatters;
    };
    lint = {
      lintersByFt.python = ["ruff"];
      linters.ruff.cmd = ruff;
    };
  };
}
