{
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers = {
      docker_compose_language_service = {
        enable = true;
      };
      dockerls = {
        enable = true;
      };
    };
    lint = {
      lintersByFt.docker = [ "hadolint" ];
      linters.hadolint.cmd = lib.getExe pkgs.hadolint;
    };
  };
}
