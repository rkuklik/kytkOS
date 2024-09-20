{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings.defaults = {
      vimgrep_arguments = [
        (lib.getExe pkgs.ripgrep)
        "-L"
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
      ];
      prompt_prefix = "   ";
      selection_caret = "  ";
      entry_prefix = "  ";
      initial_mode = "insert";
      selection_strategy = "reset";
      sorting_strategy = "ascending";
      layout_strategy = "horizontal";
      layout_config = {
        horizontal = {
          prompt_position = "top";
          preview_width = 0.5;
          preview_cutoff = 0.5;
        };
        vertical = {mirror = false;};
        width = 0.9;
        height = 0.80;
      };
      borderchars = [
        "─"
        "│"
        "─"
        "│"
        "┌"
        "┐"
        "┘"
        "└"
      ];
      color_devicons = true;
      set_env.COLORTERM = "truecolor";
      mappings = {
        n = {
          "q".__raw = "require('telescope.actions').close";
        };
        i = {
          "<A-j>".__raw = "require('telescope.actions').move_selection_next";
          "<A-k>".__raw = "require('telescope.actions').move_selection_previous";
        };
      };
    };
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Telescope files";
      };
      "<leader>fg" = {
        action = "live_grep";
        options.desc = "Telescope grep";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Telescope buffers";
      };
      "<leader>fh" = {
        action = "help_tags";
        options.desc = "Telescope help tags";
      };
    };
    extensions = {
      undo.enable = true;
      ui-select.enable = true;
    };
  };
  programs.nixvim.extraPackages = [pkgs.ripgrep pkgs.fd];
}
