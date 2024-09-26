{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    isBool
    boolToString
    filterAttrs
    mapAttrs
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  cfg = config.programs.keepassxc;
  filteredNulls =
    mapAttrs
    (name: options: filterAttrs (_: value: value != null) options)
    cfg.settings;
  modifiedSettings = filterAttrs (_: value: value != {}) filteredNulls;
  iniGen = pkgs.formats.ini {};
  iniFile = iniGen.generate "keepassxc.ini" modifiedSettings;

  mkKeePassOpt = type: default:
    mkOption {
      description = "Option which defaults to ${
        if isBool
        then boolToString default
        else toString default
      }";
      type = types.nullOr type;
      default = null;
    };
  mkBoolOpt = mkKeePassOpt types.bool;
  mkNumOpt = mkKeePassOpt types.ints.unsigned;
  mkStrOpt = mkKeePassOpt types.str;
  mkListOpt = mkKeePassOpt (types.listOf types.str);

  messaging-host = ".mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json";
in {
  options.programs.keepassxc = {
    enable = mkEnableOption "KeePassXC";
    settings = {
      General = {
        ConfigVersion = mkOption {
          description = "Config format version";
          type = types.enum [1 2];
          readOnly = true;
          default = 2;
        };
        SingleInstance = mkBoolOpt true;
        RememberLastDatabases = mkBoolOpt true;
        NumberOfRememberedLastDatabases = mkNumOpt 5;
        RememberLastKeyFiles = mkBoolOpt true;
        OpenPreviousDatabasesOnStartup = mkBoolOpt true;
        AutoSaveAfterEveryChange = mkBoolOpt true;
        AutoReloadOnChange = mkBoolOpt true;
        AutoSaveOnExit = mkBoolOpt true;
        AutoSaveNonDataChanges = mkBoolOpt true;
        BackupBeforeSave = mkBoolOpt false;
        BackupFilePathPattern = mkStrOpt "{DB_FILENAME}.old.kdbx";
        UseAtomicSaves = mkBoolOpt true;
        SearchLimitGroup = mkBoolOpt false;
        MinimizeOnOpenUrl = mkBoolOpt false;
        HideWindowOnCopy = mkBoolOpt false;
        MinimizeOnCopy = mkBoolOpt true;
        MinimizeAfterUnlock = mkBoolOpt false;
        DropToBackgroundOnCopy = mkBoolOpt false;
        UseGroupIconOnEntryCreation = mkBoolOpt true;
        AutoTypeEntryTitleMatch = mkBoolOpt true;
        AutoTypeEntryURLMatch = mkBoolOpt true;
        AutoTypeDelay = mkNumOpt 25;
        AutoTypeStartDelay = mkNumOpt 500;
        AutoTypeHideExpiredEntry = mkBoolOpt false;
        GlobalAutoTypeKey = mkNumOpt 0;
        GlobalAutoTypeModifiers = mkNumOpt 0;
        GlobalAutoTypeRetypeTime = mkNumOpt 15;
        FaviconDownloadTimeout = mkNumOpt 10;
        UpdateCheckMessageShown = mkBoolOpt false;
        DefaultDatabaseFileName = mkStrOpt "";
      };
      GUI = {
        Language = mkStrOpt "system";
        HideMenubar = mkBoolOpt false;
        HideToolbar = mkBoolOpt false;
        MovableToolbar = mkBoolOpt false;
        HidePreviewPanel = mkBoolOpt false;
        ToolButtonStyle = mkNumOpt 0;
        LaunchAtStartup = mkBoolOpt false;
        ShowTrayIcon = mkBoolOpt false;
        TrayIconAppearance = mkKeePassOpt (types.enum ["monochrome-light" "monochrome-dark"]) "";
        MinimizeToTray = mkBoolOpt false;
        MinimizeOnStartup = mkBoolOpt false;
        MinimizeOnClose = mkBoolOpt false;
        HideUsernames = mkBoolOpt false;
        HidePasswords = mkBoolOpt true;
        ColorPasswords = mkBoolOpt false;
        MonospaceNotes = mkBoolOpt false;
        ApplicationTheme = mkStrOpt "auto";
        CompactMode = mkBoolOpt false;
        CheckForUpdates = mkBoolOpt true;
        CheckForUpdatesIncludeBetas = mkBoolOpt false;
        ShowExpiredEntriesOnDatabaseUnlock = mkBoolOpt true;
        ShowExpiredEntriesOnDatabaseUnlockOffsetDays = mkNumOpt 3;
      };
      Security = {
        ClearClipboard = mkBoolOpt true;
        ClearClipboardTimeout = mkNumOpt 10;
        ClearSearch = mkBoolOpt false;
        ClearSearchTimeout = mkNumOpt 5;
        Security_HideNotes = mkBoolOpt false;
        LockDatabaseIdle = mkBoolOpt false;
        LockDatabaseIdleSeconds = mkNumOpt 240;
        LockDatabaseMinimize = mkBoolOpt false;
        LockDatabaseScreenLock = mkBoolOpt true;
        LockDatabaseOnUserSwitch = mkBoolOpt true;
        RelockAutoType = mkBoolOpt false;
        PasswordsHidden = mkBoolOpt true;
        PasswordEmptyPlaceholder = mkBoolOpt false;
        HidePasswordPreviewPanel = mkBoolOpt true;
        HideTotpPreviewPanel = mkBoolOpt false;
        AutotypeAsk = mkBoolOpt true;
        IconDownloadFallback = mkBoolOpt false;
        NoConfirmMoveEntryToRecycleBin = mkBoolOpt true;
        EnableCopyOnDoubleClick = mkBoolOpt false;
      };
      Browser = {
        Enabled = mkBoolOpt false;
        ShowNotification = mkBoolOpt true;
        BestMatchOnly = mkBoolOpt false;
        UnlockDatabase = mkBoolOpt true;
        MatchUrlScheme = mkBoolOpt true;
        SupportBrowserProxy = mkBoolOpt true;
        UseCustomProxy = mkBoolOpt false;
        CustomProxyLocation = mkStrOpt "";
        UpdateBinaryPath = mkBoolOpt true;
        AllowGetDatabaseEntriesRequest = mkBoolOpt false;
        AllowExpiredCredentials = mkBoolOpt false;
        AlwaysAllowAccess = mkBoolOpt false;
        AlwaysAllowUpdate = mkBoolOpt false;
        HttpAuthPermission = mkBoolOpt false;
        SearchInAllDatabases = mkBoolOpt false;
        SupportKphFields = mkBoolOpt true;
        NoMigrationPrompt = mkBoolOpt false;
        Browser_AllowLocalhostWithPasskeys = mkBoolOpt false;
      };
      SSHAgent = {
        Enabled = mkBoolOpt false;
        UseOpenSSH = mkBoolOpt false;
        UsePageant = mkBoolOpt true;
      };
      FdoSecrets = {
        Enabled = mkBoolOpt false;
        ShowNotification = mkBoolOpt true;
        ConfirmDeleteItem = mkBoolOpt true;
        ConfirmAccessItem = mkBoolOpt true;
        UnlockBeforeSearch = mkBoolOpt true;
      };
      KeeShare = {
        QuietSuccess = mkBoolOpt false;
        Own = mkStrOpt "";
        Foreign = mkStrOpt "";
        Active = mkStrOpt "";
      };
      PasswordGenerator = {
        LowerCase = mkBoolOpt true;
        UpperCase = mkBoolOpt true;
        Numbers = mkBoolOpt true;
        EASCII = mkBoolOpt false;
        AdvancedMode = mkBoolOpt false;
        SpecialChars = mkBoolOpt true;
        Braces = mkBoolOpt false;
        Punctuation = mkBoolOpt false;
        Quotes = mkBoolOpt false;
        Dashes = mkBoolOpt false;
        Math = mkBoolOpt false;
        Logograms = mkBoolOpt false;
        AdditionalChars = mkListOpt [];
        ExcludedChars = mkListOpt [];
        ExcludeAlike = mkBoolOpt true;
        EnsureEvery = mkBoolOpt true;
        Length = mkNumOpt 20;
        WordCount = mkNumOpt 7;
        WordSeparator = mkStrOpt " ";
        WordList = mkStrOpt "eff_large.wordlist";
        WordCase = mkNumOpt 0;
        Type = mkNumOpt 0;
      };
      Messages = {
        NoLegacyKeyFileWarning = mkBoolOpt false;
      };
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."keepassxc/keepassxc.ini".source = iniFile;
    home = {
      packages = [pkgs.keepassxc];
      file.${messaging-host}.text = builtins.toJSON {
        allowed_extensions = ["keepassxc-browser@keepassxc.org"];
        description = "KeePassXC integration with native messaging support";
        name = "org.keepassxc.keepassxc_browser";
        path = lib.getExe' pkgs.keepassxc "keepassxc-proxy";
        type = "stdio";
      };
    };
  };
}
