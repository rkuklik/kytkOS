{
  inputs,
  os,
  name,
  lib,
  ...
}:
{
  imports = [ inputs.walker.homeManagerModules.walker ];
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      search.placeholder = "Example";
    };
    theme = null;
  };
}
