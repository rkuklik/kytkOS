{
  config,
  ...
}:
{
  accounts.email = {
    maildirBasePath = "${config.xdg.dataHome}/maildir";
    accounts = {
      centrum = {
        address = "kuklik.radek@centrum.cz";
        userName = "kuklik.radek@centrum.cz";
        realName = "Kuklík Radek";
        primary = true;
        thunderbird.enable = true;
        imap = {
          host = "imap.centrum.cz";
          port = 993;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };
        smtp = {
          host = "smtp.centrum.cz";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
      };
      expect-it = {
        address = "rkuklik@expect-it.cz";
        userName = "rkuklik";
        realName = "Kuklík Radek";
        thunderbird.enable = true;
        imap = {
          host = "mail.expect-it.cz";
          port = 9993;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };
        smtp = {
          host = "mail.centrum.cz";
          port = 9025;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
      };
      fykos = {
        address = "radek.kuklik@fykos.cz";
        userName = "radek.kuklik@fykos.cz";
        realName = "Kuklík Radek";
        flavor = "gmail.com";
        thunderbird.enable = true;
      };
    };
  };
}
