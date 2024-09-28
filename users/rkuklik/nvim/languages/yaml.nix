{
  programs.nixvim.plugins = {
    lsp.servers.yamlls = {
      enable = true;
    };
    conform-nvim.settings = {
      formatters_by_ft.yaml = {
        __unkeyed-prettierd = "prettierd";
      };
    };
  };
}
