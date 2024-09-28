{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = ["filename"];
          lualine_x = ["encoding" "fileformat" "filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
        inactive_sections = {
          lualine_c = ["filename"];
          lualine_x = ["location"];
        };
        options = {
          globalstatus = true;
          always_divide_middle = true;
          icons_enabled = false;
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
        };
      };
    };
    plugins.navic = {
      enable = true;
      settings.lsp.auto_attach = true;
    };
  };
}
