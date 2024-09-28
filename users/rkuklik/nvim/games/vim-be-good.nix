{pkgs, ...}: {
  programs.nixvim.extraPlugins = [pkgs.vimPlugins.vim-be-good];
}
