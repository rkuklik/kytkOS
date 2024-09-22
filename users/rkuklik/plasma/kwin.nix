{
  programs.plasma.kwin = {
    virtualDesktops = {
      rows = 1;
      names = [
        "One"
        "Two"
        "Three"
        "Four"
        "Five"
        "Six"
        "Seven"
        "Eight"
        "Nine"
      ];
    };
    effects = {
      desktopSwitching.animation = "slide";
      blur.enable = true;
      shakeCursor.enable = true;
      snapHelper.enable = true;
    };
  };
}
