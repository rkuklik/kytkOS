{
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim = {
    plugins = {
      rustaceanvim = {
        enable = true;
        rustAnalyzerPackage = pkgs.rust-bin.stable.latest.rust-analyzer;
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
            cargo = { };
            imports.granularity.group = "preserve";
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
  };
}
