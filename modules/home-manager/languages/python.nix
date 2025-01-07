{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.flowerbed.languages.python;
in
{
  options.flowerbed.languages.python = {
    enable = mkEnableOption "Python";
  };
  config = {
    home = {
      packages = mkIf (cfg.enable) [ pkgs.python3 ];
      sessionVariables = {
        PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
      };
    };
    xdg.configFile."python/pythonrc".text =
      # python
      ''
        from sys import argv

        if not hasattr(__builtins__, "__IPYTHON__") and "bpython" not in argv[0]:
            from atexit import register
            from os import environ
            from pathlib import Path
            from readline import read_history_file, write_history_file

            if state_home := environ.get("XDG_STATE_HOME"):
                state_home = Path(state_home)
            else:
                state_home = Path.home() / ".local" / "state"

            history = str(state_home / "python_history")

            try:
                read_history_file(history)
            except:
                pass
            register(write_history_file, history)
      '';
  };
}
