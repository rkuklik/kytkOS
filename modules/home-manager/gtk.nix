{
  config,
  lib,
  os,
  ...
}:
let
  gtk2rc = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  gtk2rcDefault = "${config.home.homeDirectory}/.gtkrc-2.0";
  backup = name: "${name}.${os.home-manager.backupFileExtension}";
  delete = [
    gtk2rcDefault
    (backup gtk2rcDefault)
    (backup gtk2rc)
  ];
  spaced = lib.concatStringsSep " ";
  files = map (name: ''"${name}"'') delete;
in
{
  gtk.gtk2.configLocation = gtk2rc;
  home.file.${gtk2rc} = {
    text = lib.mkDefault "";
    force = true;
    onChange =
      # bash
      ''
        for file in ${spaced files}; do
          if [[ -e $file ]]; then
            rm "$backup"
          fi
        done
      '';
  };
}
