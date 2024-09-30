{
  programs.wezterm = {
    enable = true;
    extraConfig =
      # lua
      ''
        return {
          use_fancy_tab_bar = false,
          warn_about_missing_glyphs = false,
          enable_kitty_graphics = true,
          hide_tab_bar_if_only_one_tab = true,
          window_padding = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0,
          },
        }
      '';
  };
}
