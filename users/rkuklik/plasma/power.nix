{
  programs.plasma.powerdevil = {
    general.pausePlayersOnSuspend = true;
    AC = {
      dimDisplay = {
        enable = true;
        idleTimeout = 5 * 60;
      };
      turnOffDisplay = {
        idleTimeout = 10 * 60;
        idleTimeoutWhenLocked = 60;
      };
      autoSuspend.action = "nothing";
      powerButtonAction = "showLogoutScreen";
      whenLaptopLidClosed = "sleep";
      inhibitLidActionWhenExternalMonitorConnected = true;
    };
    battery = {
      dimDisplay = {
        enable = true;
        idleTimeout = 2 * 60;
      };
      turnOffDisplay = {
        idleTimeout = 5 * 60;
        idleTimeoutWhenLocked = 60;
      };
      autoSuspend.action = "sleep";
      powerButtonAction = "showLogoutScreen";
      whenLaptopLidClosed = "sleep";
      inhibitLidActionWhenExternalMonitorConnected = true;
    };
    lowBattery = {
      dimDisplay = {
        enable = true;
        idleTimeout = 1 * 60;
      };
      turnOffDisplay = {
        idleTimeout = 2 * 60;
        idleTimeoutWhenLocked = 60;
      };
      autoSuspend.action = "nothing";
      powerButtonAction = "showLogoutScreen";
      whenLaptopLidClosed = "sleep";
      inhibitLidActionWhenExternalMonitorConnected = true;
    };
  };
}
