{
  lib,
  pkgs,
  ...
}:
let
  inherit (builtins)
    map
    listToAttrs
    attrValues
    ;
  shellfmt = {
    __unkeyed-shellharden = "shellharden";
    __unkeyed-shfmt = "shfmt";
    __unkeyed-shellcheck = "shellcheck";
  };
  packager = name: {
    inherit name;
    value.command = lib.getExe pkgs."${name}";
  };
in
{
  programs.nixvim.plugins = {
    lsp.servers.bashls = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft = {
        sh = shellfmt;
        bash = shellfmt;
      };
      formatters = listToAttrs (map packager (attrValues shellfmt));
    };
    lint = {
      lintersByFt = {
        sh = [ "shellcheck" ];
        bash = [ "shellcheck" ];
        fish = [ "fish" ];
      };
      linters = {
        shellcheck.cmd = lib.getExe pkgs.shellcheck;
        fish.cmd = lib.getExe' pkgs.fish "fish";
      };
    };
  };
}
