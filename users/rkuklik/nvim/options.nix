{
  programs.nixvim = {
    opts = {
      tabstop = 4;
      shiftwidth = 4;
      shiftround = true;
      expandtab = true;
      wrap = false;
      scrolloff = 6;
      signcolumn = "no";

      swapfile = false;
      backup = false;
      undofile = true;

      #guicursor = "";
      termguicolors = true;
      cursorline = true;
      number = true;
      relativenumber = true;
      showmode = false;
      hlsearch = false;
      incsearch = true;

      foldmethod = "expr";
      foldlevelstart = 99;

      updatetime = 250;
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    clipboard = {
      register = "unnamed";
      providers.wl-copy.enable = true;
    };
  };
}
