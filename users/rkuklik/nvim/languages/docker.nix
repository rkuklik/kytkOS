{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    lsp.servers = {
      docker-compose-language-service = {
        enable = true;
      };
      dockerls = {
        enable = true;
      };
    };
    lint = {
      lintersByFt.docker = ["hadolint"];
      linters.hadolint.cmd = lib.getExe pkgs.hadolint;
    };
  };
}
