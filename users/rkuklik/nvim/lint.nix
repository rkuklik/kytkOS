{
  programs.nixvim.plugins.lint = {
    enable = true;
    autoCmd = {
      event = ["BufWritePost" "BufReadPost" "InsertLeave"];
      callback.__raw =
        # lua
        ''
          function()
            require('lint').try_lint(nil, { ignore_errors = true })
          end
        '';
    };
  };
}
