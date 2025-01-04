let
  bar = {
    location = "top";
    alignment = "center";
    lengthMode = "fill";
    height = 28;
    screen = 0;
    # https://develop.kde.org/docs/plasma/scripting/keys/
    widgets = [
      {
        name = "org.kde.plasma.pager";
      }
      {
        name = "org.kde.plasma.panelspacer";
      }
      {
        name = "org.kde.plasma.digitalclock";
        config.Appearance = {
          showLocalTimezone = true;
          showWeekNumbers = true;
          firstDayOfWeek = 1;
          dateDisplayFormat = 1;
          use24hFormat = 2;
          enabledCalendarPlugins = [
            "astronomicalevents"
            "holidaysevents"
          ];
        };
      }
      {
        name = "org.kde.plasma.panelspacer";
      }
      {
        name = "org.kde.plasma.systemtray";
        config.General = rec {
          scaleIconsToFit = true;
          spacing = 2;
          shownItems = [
            "org.kde.plasma.volume"
            "org.kde.plasma.battery"
            "org.kde.plasma.networkmanagement"
            "org.kde.plasma.clipboard"
            "org.kde.plasma.bluetooth"
            "org.kde.plasma.notifications"
            "KeePassXC"
          ];
          extraItems = [
            "org.kde.plasma.bluetooth"
            "org.kde.plasma.battery"
            "org.kde.plasma.clipboard"
            "org.kde.plasma.devicenotifier"
            "org.kde.plasma.manage-inputmethod"
            "org.kde.plasma.mediacontroller"
            "org.kde.plasma.notifications"
            "org.kde.plasma.keyboardindicator"
            "org.kde.plasma.keyboardlayout"
            "org.kde.plasma.networkmanagement"
            "org.kde.plasma.volume"
            "org.kde.plasma.vault"
            "org.kde.kdeconnect"
            "org.kde.kscreen"
            "org.kde.plasma.printmanager"
            "org.kde.plasma.brightness"
            "org.kde.plasma.cameraindicator"
          ];
          knownItems = extraItems;
        };
      }
    ];
  };
in
{
  programs.plasma.panels = [ bar ];
}
