{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp.servers.gopls = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.go = {
        __unkeyed-goimports = "goimports";
        __unkeyed-gofmt = "gofmt";
      };
      formatters = {
        gofmt.command = lib.getExe' pkgs.go "gofmt";
        goimports.command = lib.getExe' pkgs.gotools "goimports";
      };
    };
  };
}
