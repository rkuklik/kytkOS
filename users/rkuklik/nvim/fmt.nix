{config, ...}: let
  inherit
    (builtins)
    map
    listToAttrs
    ;
  fmtOpts = {
    lsp_format = "fallback";
    timeout_ms = 5000;
  };
  cmd = {
    name,
    buffer,
    global,
  }: {
    name = "Format${name}";
    value = {
      bang = true;
      desc = "${name} autoformat (bang for buffer)";
      command.__raw =
        # lua
        ''
          function(args)
            if args.bang then
              ${buffer}
            else
              ${global}
            end
          end
        '';
    };
  };
  disable = {
    name = "Disable";
    buffer = "vim.b[0].autoformat = false";
    global = "vim.g.autoformat = false";
  };
  enable = {
    name = "Enable";
    buffer = "vim.b[0].autoformat = true";
    global = "vim.g.autoformat = true";
  };
  toggle = {
    name = "Toggle";
    buffer =
      # lua
      ''
        if vim.b[0].autoformat == nil then
            vim.b[0].autoformat = not vim.g.autoformat
        else
            vim.b[0].autoformat = not vim.b[0].autoformat
        end
      '';
    global = "vim.g.autoformat = not vim.g.autoformat";
  };
in {
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings.format_on_save =
      # lua
      ''
        function(bufnr)
          local buf = vim.b[bufnr].autoformat
          local fmt = vim.g.autoformat
          if vim.b[bufnr].autoformat ~= nil then
            fmt = vim.b[bufnr].autoformat
          end
          if fmt then return ${config.lib.nixvim.toLuaObject fmtOpts} end
        end
      '';
  };
  programs.nixvim = {
    globals.autoformat = true;
    opts.formatexpr = "v:lua.require('conform').formatexpr()";
    userCommands = listToAttrs (map cmd [disable enable toggle]);
  };
}
