{
  programs.nixvim.plugins.lint = {
    enable = true;
    autoCmd.callback.__raw =
      # lua
      "require('lint').try_lint(nil, { ignore_errors = true })";
  };
}
