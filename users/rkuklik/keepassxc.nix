{
  programs.keepassxc = {
    enable = true;
    settings = {
      General = {
        UseAtomicSaves = true;
      };
      Browser = {
        Enabled = true;
        SearchInAllDatabases = true;
      };
      FdoSecrets = {
        Enabled = true;
      };
      GUI = {
        ApplicationTheme = "classic";
        CompactMode = true;
        HidePasswords = false;
        ShowTrayIcon = true;
        MinimizeOnClose = true;
        MinimizeOnStartup = true;
        MinimizeToTray = true;
        MonospaceNotes = true;
        ColorPasswords = true;
        TrayIconAppearance = "monochrome-light";
      };
      PasswordGenerator = {
        Length = 32;
        SpecialChars = true;
      };
      Security = {
        ClearClipboard = false;
        ClearSearch = false;
        IconDownloadFallback = true;
        LockDatabaseScreenLock = false;
      };
    };
  };
}
