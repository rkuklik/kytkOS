{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.flowerbed.languages;
in {
  options.flowerbed.languages.python = {
    enable = mkEnableOption "Python";
  };
  config = mkIf (cfg.python.enable) {
    home = {
      packages = [pkgs.python3];
      sessionVariables = {
        PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
      };
    };
    xdg.configFile."python/pythonrc".text =
      # python
      ''
        import sys

        if not hasattr(__builtins__, '__IPYTHON__') and 'bpython' not in sys.argv[0]:
            import os
            import atexit
            import readline
            from pathlib import Path

            if state_home := os.environ.get('XDG_STATE_HOME'):
                state_home = Path(state_home)
            else:
                state_home = Path.home() / '.local' / 'state'

            history = str(state_home / 'python_history')

            try:
                readline.read_history_file(history)
            except:
                pass
            atexit.register(readline.write_history_file, history)
      '';
  };
}
