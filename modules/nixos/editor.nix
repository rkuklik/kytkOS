{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.kytkos.editor;
in {
  options.kytkos.editor = {
    enable = mkEnableOption "Editor" // {default = true;};
  };

  config = {
    programs = {
      nano.enable = false;
      neovim = mkIf cfg.enable {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };
    };
  };
}
