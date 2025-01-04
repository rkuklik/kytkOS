{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers.texlab = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft = {
        tex.__unkeyed-latexindent = "latexindent";
      };
      formatters.latexindent.command = lib.getExe' (pkgs.texlive.withPackages (ps: [
        ps.latexindent
      ])) "latexindent";
    };
  };
}
