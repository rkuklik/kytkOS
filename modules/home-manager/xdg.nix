{
  config,
  ...
}:
let
  inherit (config.xdg)
    configHome
    dataHome
    stateHome
    ;
in
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
  home = {
    preferXdgDirectories = true;
    # xdg-ninja cleanup
    sessionVariables = {
      ANDROID_USER_HOME = "${dataHome}/android";
      ANDROID_HOME = "${dataHome}/android/sdk";
      DOCKER_CONFIG = "${configHome}/docker";
      DOT_SAGE = "${configHome}/sage";
      GRADLE_USER_HOME = "${dataHome}/gradle";
      NODE_REPL_HISTORY = "${stateHome}/node_repl_history";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configHome}/java";
    };
  };
}
