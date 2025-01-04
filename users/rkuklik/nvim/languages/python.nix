{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) listToAttrs;
  names = map (name: "ruff_${name}") [
    "fix"
    "format"
    "organize_imports"
  ];
  ruff = lib.getExe pkgs.ruff;
  transformed = fn: listToAttrs (map fn names);
  formatters = name: {
    inherit name;
    value.command = ruff;
  };
  unkeyed = name: {
    name = "__unkeyed-${name}";
    value = name;
  };
in {
  programs.nixvim.plugins = {
    lsp.servers.pyright = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.python = transformed unkeyed;
      formatters = transformed formatters;
    };
    lint = {
      lintersByFt.python = ["ruff"];
      linters.ruff.cmd = ruff;
    };
  };
}
