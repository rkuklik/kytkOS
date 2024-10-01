{config, ...}: let
  inherit
    (config.xdg)
    configHome
    dataHome
    stateHome
    ;
in {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    configFile."python/pythonrc".text =
      # python
      ''
        def is_vanilla() -> bool:
            import sys
            return not hasattr(__builtins__, '__IPYTHON__') and 'bpython' not in sys.argv[0]


        def setup_history():
            import os
            import atexit
            import readline
            from pathlib import Path

            if state_home := os.environ.get('XDG_STATE_HOME'):
                state_home = Path(state_home)
            else:
                state_home = Path.home() / '.local' / 'state'

            history: Path = state_home / 'python_history'

            try:
                readline.read_history_file(str(history))
            except:
                pass
            atexit.register(readline.write_history_file, str(history))


        if is_vanilla():
            setup_history()
      '';
  };
  home = {
    preferXdgDirectories = true;
    # xdg-ninja cleanup
    sessionVariables = {
      ANDROID_USER_HOME = "${dataHome}/android";
      CARGO_HOME = "${dataHome}/cargo";
      DOCKER_CONFIG = "${configHome}/docker";
      GRADLE_USER_HOME = "${dataHome}/gradle";
      NODE_REPL_HISTORY = "${stateHome}/node_repl_history";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configHome}/java";
      PYTHONSTARTUP = "${configHome}/python/pythonrc";
      RUSTUP_HOME = "${dataHome}/rustup";
    };
  };
}
