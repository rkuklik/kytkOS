{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    settings = {
      cursor-style = "block";
      cursor-click-to-move = true;
      mouse-hide-while-typing = true;
    };
  };
}
