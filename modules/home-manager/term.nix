{lib, ...}: {
  options.flowerbed.terminal = {
    enable = lib.mkEnableOption "Enable terminal emulators";
  };
}
