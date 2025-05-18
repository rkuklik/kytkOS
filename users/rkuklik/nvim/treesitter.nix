{
  programs.nixvim = {
    plugins = {
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
    autoCmd = [
      {
        event = "BufReadPre";
        desc = "Disable treesitter folding for large files";
        callback.__raw = ''
          function(ev)
            local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(ev.buf))
            opt = vim.opt_local
            if not ok or size > 1024 * 1024 then -- MB threshold
              opt.foldmethod = "manual"
              opt.foldexpr = "0"
              opt.foldlevel = 0
              opt.foldtext = "foldtext()"
            end
          end
        '';
      }
    ];
  };
}
