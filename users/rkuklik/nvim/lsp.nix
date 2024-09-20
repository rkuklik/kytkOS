{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps.extra = [
      {
        key = "gd";
        action.__raw = "function() require('telescope.builtin').lsp_definitions(rw) end";
        options.desc = "Goto Definition";
      }
      {
        key = "gr";
        action.__raw = "function() require('telescope.builtin').lsp_references(rw) end";
        options.desc = "References";
      }
      {
        key = "gD";
        action.__raw = "vim.lsp.buf.declaration";
        options.desc = "Goto Declaration";
      }
      {
        key = "gI";
        action.__raw = "function() require('telescope.builtin').lsp_implementations(rw) end";
        options.desc = "Goto Implementation";
      }
      {
        key = "gy";
        action.__raw = "function() require('telescope.builtin').lsp_type_definitions(rw) end";
        options.desc = "Goto Type Definition";
      }
      {
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Hover";
      }
      {
        key = "gK";
        action.__raw = "vim.lsp.buf.signature_help";
        options.desc = "Signature Help";
        #has = "signatureHelp";
      }
      {
        key = "<C-h>";
        action.__raw = "vim.lsp.buf.signature_help";
        options.desc = "Signature Help";
        mode = "i";
        #has = "signatureHelp";
      }
      {
        key = "<leader>ca";
        action.__raw = "vim.lsp.buf.code_action";
        options.desc = "Code Action";
        mode = ["n" "v"];
        #has = "codeAction";
      }
      {
        key = "<leader>cA";
        action.__raw =
          # lua
          ''
            function()
              vim.lsp.buf.code_action({
                context = {
                  only = {
                    "source",
                  },
                  diagnostics = {},
                },
              })
            end
          '';
        options.desc = "Source Action";
        #has = "codeAction";
      }
      {
        key = "<leader>r";
        action.__raw = "vim.lsp.buf.rename";
        options.desc = "Rename";
      }
    ];
  };
}
