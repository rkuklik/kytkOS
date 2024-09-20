{
  lib,
  pkgs,
  ...
}: let
  wind.__unkeyed-rustywind = "rustywind";
in {
  programs.nixvim.plugins = {
    lsp.servers.tailwindcss = {
      enable = true;
      filetypes = ["rust"];
      settings = {userLanguages.rust = "html";};
    };
    conform-nvim.settings = {
      formatters_by_ft = {
        html = wind;
        rust = wind;
      };
      formatters.rustywind.command = lib.getExe pkgs.rustywind;
    };
  };
}
