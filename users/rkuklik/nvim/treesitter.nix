{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      folding = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-space>";
            node_incremental = "<C-space>";
            scope_incremental = "<C-s>";
            node_decremental = "<C-backspace>";
          };
          #// {
          #  init_selection = "gnn";
          #  node_incremental = "grm";
          #  scope_incremental = "grn";
          #  node_decremental = "grc";
          #}
        };
        indent.enable = true;
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 9;
      };
    };
    treesitter-textobjects = {
      enable = true;
    };
  };
}
