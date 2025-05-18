{
  lib,
  pkgs,
  ...
}:
let
  sniffer = lib.getExe' pkgs.php84Packages.php-codesniffer;
  names = {
    cbf = "phpcbf";
    cs = "phpcs";
  };
in
{
  programs.nixvim.plugins = {
    lsp.servers.phpactor = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.php = {
        "__unkeyed-${names.cbf}" = names.cbf;
      };
      formatters.phpcbf.command = sniffer names.cbf;
    };
    #lint = {
    #  lintersByFt.php = [ names.cs ];
    #  linters.phpcs.cmd = sniffer names.cs;
    #};
  };
}
