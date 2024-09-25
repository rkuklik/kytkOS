{
  kytkos = {
    users.rkuklik = {
      name = "Kuklík Radek";
      admin = true;
      net = true;
      home-manager = {
        enable = true;
        settings.flowerbed = {
          terminal.enable = true;
        };
      };
    };
    boot = {
      loader = "grub";
      mode = "bios";
      memtest = true;
    };
    desktop.plasma.enable = true;
    login.tuigreet.enable = true;
  };
}
