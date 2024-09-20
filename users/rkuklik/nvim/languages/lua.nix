{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp.servers.lua-ls = {
      enable = true;
      settings = {
        workspace.checkThirdParty = true;
        runtime.version = "LuaJIT";
        telemetry.enable = false;
      };
    };
    conform-nvim.settings = {
      formatters_by_ft.lua = {
        __unkeyed-stylua = "stylua";
      };
      formatters.stylua.command = lib.getExe pkgs.stylua;
    };
  };
}
