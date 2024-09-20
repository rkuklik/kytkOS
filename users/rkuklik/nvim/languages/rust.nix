{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        tools = {
          on_initialized.__raw =
            # lua
            ''
              function()
                vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
              end
            '';
        };
        server.default_settings.rust-analyzer = {
          cargo = {};
          procMacro = {
            enable = true;
          };
        };
      };
    };
    conform-nvim.settings = {
      formatters_by_ft.rust = {
        __unkeyed-rustfmt = "rustfmt";
      };
      formatters.rustfmt.command = lib.getExe pkgs.rustfmt;
    };
  };
}
