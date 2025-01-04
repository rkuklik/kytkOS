{ config, ... }:
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
      DOCKER_CONFIG = "${configHome}/docker";
      GRADLE_USER_HOME = "${dataHome}/gradle";
      NODE_REPL_HISTORY = "${stateHome}/node_repl_history";
      DOTNET_CLI_HOME = "${dataHome}/dotnet";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${configHome}/java";
    };
  };
}
