let
  inherit (builtins) map;
  named = name: {inherit name;};
  mapping = body: {__raw = "cmp.mapping.${body}";};
  select = "{ behavior = cmp.SelectBehavior.Select }";
  darkarts =
    # lua
    ''
      -- should check if there are chars before cursor
      local darkarts = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return true
          and col ~= 0
          and vim.api
                  .nvim_buf_get_lines(0, line - 1, line, true)[1]
                  :sub(col, col)
                  :match("%s")
              == nil
      end
    '';
  selector = body:
  # lua
  ''
    cmp.mapping(function(fallback)
      ${body}
    end, { 'i', 's' })
  '';
  jump_local = count:
    selector
    # lua
    ''
      local luasnip = require('luasnip')
      if luasnip.locally_jumpable(${count}) then
        luasnip.jump(${count})
      end
    '';
in {
  programs.nixvim.plugins = {
    friendly-snippets.enable = true;
    luasnip.enable = true;
    cmp = {
      enable = true;
      settings = {
        sources = map named [
          "nvim_lsp"
          "luasnip"
          "buffer"
          "path"
          "crates"
        ];
        completion.completeopt = "menu,menuone,noinsert,noselect";
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        mapping = {
          "<C-n>" = mapping "select_next_item(${select})";
          "<C-p>" = mapping "select_prev_item(${select})";
          "<C-b>" = mapping "scroll_docs(-4)";
          "<C-f>" = mapping "scroll_docs(4)";
          #"<C-Space>" = mapping "complete()";
          "<C-e>" = mapping "abort()";
          "<CR>" = mapping "confirm({ select = false })";
          "<S-CR>" =
            mapping
            # lua
            ''
              confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              })
            '';
          "<Tab>" =
            selector
            # lua
            ''
              ${darkarts}
              if cmp.visible() then
                cmp.select_next_item()
              elseif darkarts() then
                cmp.complete()
              else
                fallback()
              end
            '';
          "<S-Tab>" =
            selector
            # lua
            ''
              if cmp.visible() then
                cmp.select_prev_item()
              end
            '';
          "<C-s>" = jump_local "1";
          "<C-S-s>" = jump_local "(-1)";
        };
      };
      cmdline = let
        search = {
          mapping = mapping "preset.cmdline()";
          sources = map named ["buffer"];
          view.entries = {
            name = "wildmenu";
            separator = " | ";
          };
        };
        command = {
          mapping = mapping "preset.cmdline()";
          sources = map named ["path" "cmdline"];
        };
      in {
        "/" = search;
        "?" = search;
        ":" = command;
      };
    };
  };
}
