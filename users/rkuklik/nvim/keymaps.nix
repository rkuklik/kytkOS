let
  all = ["n" "v" "o" "i"];
in {
  programs.nixvim.keymaps = [
    # clipboard
    {
      key = "<leader>p";
      action = "\"_dP";
      mode = "x";
    }
    {
      key = "<leader>p";
      action = "\"+p";
    }
    {
      key = "<leader>P";
      action = "\"+P";
    }
    {
      key = "<leader>y";
      action = "\"+y";
    }
    {
      key = "<leader>y";
      action = "\"+y";
      mode = "v";
    }
    {
      key = "<leader>Y";
      action = "\"+Y";
    }
    {
      key = "<leader>d";
      action = "\"_d";
      mode = ["n" "v"];
    }
    # tabs
    {
      key = "<C-t>";
      action = ":tabnew<CR>";
    }
    # touchpad
    {
      key = "<ScrollWheelUp>";
      action = "<Up>";
      mode = all;
    }
    {
      key = "<ScrollWheelDown>";
      action = "<Down>";
      mode = all;
    }
    {
      key = "<ScrollWheelLeft>";
      action = "<Left>";
      mode = all;
    }
    {
      key = "<ScrollWheelRight>";
      action = "<Right>";
      mode = all;
    }
    # windows
    {
      key = "<A-h>";
      action = "<C-w>h";
    }
    {
      key = "<A-j>";
      action = "<C-w>j";
    }
    {
      key = "<A-k>";
      action = "<C-w>k";
    }
    {
      key = "<A-l>";
      action = "<C-w>l";
    }
    {
      key = "<C-h>";
      action = "<C-w>h";
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
    }
    # edit
    {
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      mode = "v";
    }
    {
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      mode = "v";
    }
    # navigation
    {
      key = "<leader>e";
      action.__raw = "vim.cmd.Ex";
    }
    {
      key = "J";
      action = "mzJ`z";
    }
    {
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      key = "<C-u>";
      action = "<C-u>zz";
    }
    {
      key = "<PageUp>";
      action = "<C-u>zz";
    }
    {
      key = "<PageDown>";
      action = "<C-d>zz";
    }
    {
      key = "n";
      action = "nzzzv";
    }
    {
      key = "N";
      action = "Nzzzv";
    }
    {
      key = "<C-\\><Esc>";
      action = "<C-\\><C-n>";
      mode = "t";
    }
    {
      key = "<leader>s";
      action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
    }
    # diagnostic
    {
      key = "<leader>vws";
      action.__raw = "vim.lsp.buf.workspace_symbol";
    }
    {
      key = "<leader>do";
      action.__raw = "vim.diagnostic.open_float";
    }
    {
      key = "<leader>dn";
      action.__raw = "vim.diagnostic.goto_next";
    }
    {
      key = "<leader>dN";
      action.__raw = "vim.diagnostic.goto_prev";
    }
    {
      key = "<leader>ca";
      action.__raw = "vim.lsp.buf.code_action";
    }
  ];
}
