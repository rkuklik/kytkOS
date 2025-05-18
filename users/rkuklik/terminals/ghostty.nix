{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    settings = {
      shell-integration-features = "no-cursor";
      cursor-style = "block";
      cursor-style-blink = false;
      cursor-click-to-move = true;
      mouse-hide-while-typing = true;
    };
  };
}
