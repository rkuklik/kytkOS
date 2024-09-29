{
  programs.plasma.input = {
    keyboard.layouts = [
      {
        layout = "us";
      }
      {
        layout = "cz";
        variant = "qwerty";
      }
    ];
    keyboard.numlockOnStartup = "on";
    touchpads = [
      {
        enable = true;
        disableWhileTyping = false;
        middleButtonEmulation = true;
        name = "DELL0A78:00 04F3:3147 Touchpad";
        naturalScroll = true;
        vendorId = "04f3";
        productId = "3147";
        scrollMethod = "twoFingers";
        tapToClick = true;
      }
    ];
  };
}
