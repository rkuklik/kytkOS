{
  kytkos = {
    users.rkuklik = {
      name = "Kuklík Radek";
      admin = true;
      net = true;
      password = "$y$j9T$zeuWFGUQNdMoN0RB1D3Y1.$ZtYNmx2PlHzvuRqDEi0ox/PJawgepmCZW5fFVLN5Zs3";
      home-manager.enable = true;
    };
    boot = {
      loader = "grub";
      mode = "uefi";
      memtest = true;
    };
    desktop.plasma.enable = true;
    audio.enable = true;
    net = {
      enable = true;
      blacklist = {
        enable = true;
        fakenews = true;
        gambling = true;
        porn = true;
      };
    };
    bluetooth.enable = true;
    containers.enable = true;
    login.tuigreet.enable = true;
  };
}
