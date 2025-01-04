{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.flutter-tools-nvim ];
    plugins.treesitter.enable = true;
    extraConfigLua =
      # lua
      ''
        do
          require("flutter-tools").setup({})
        end
      '';
  };
}
