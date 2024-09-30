{
  programs.alacritty = {
    enable = true;
    settings = {
      font.builtin_box_drawing = true;
      window = {
        dynamic_padding = false;
        dynamic_title = false;
        startup_mode = "Windowed";
        title = "Alacritty";
        blur = true;
      };
    };
  };
}
