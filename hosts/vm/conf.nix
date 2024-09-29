{
  kytkos = {
    users.rkuklik = {
      name = "Kuklík Radek";
      admin = true;
      net = true;
      password = "$y$j9T$zeuWFGUQNdMoN0RB1D3Y1.$ZtYNmx2PlHzvuRqDEi0ox/PJawgepmCZW5fFVLN5Zs3";
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
