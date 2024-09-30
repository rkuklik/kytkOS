{
  programs.plasma.configFile = {
    kwalletrc = {
      Wallet = {
        "Enabled" = false;
        "Close When Idle" = false;
        "Close on Screensaver" = false;
        "First Use" = false;
        "Idle Timeout" = 10;
        "Launch Manager" = true;
        "Leave Manager Open" = true;
        "Leave Open" = true;
        "Prompt on Open" = false;
        "Use One Wallet" = true;
      };
      "org.freedesktop.secrets".apiEnabled = false;
    };
    kwinrc.Windows = {
      ElectricBorders = 1;
      FocusPolicy = "FocusFollowsMouse";
    };
  };
}
