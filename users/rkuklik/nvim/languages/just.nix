{
  lib,
  pkgs,
  ...
}:
let
  just = lib.getExe pkgs.just;
in
{
  programs.nixvim.plugins = {
    conform-nvim.settings = {
      formatters_by_ft.just = {
        __unkeyed-just = "just";
      };
      formatters.just.command = just;
    };
  };
}
