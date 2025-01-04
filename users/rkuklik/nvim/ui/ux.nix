let
  enabled.__raw = "{}";
in
{
  programs.nixvim.plugins = {
    hardtime = {
      enable = true;
      settings = {
        restriction_mode = "hint";
        disabled_keys = {
          "<Up>" = enabled;
          "<Down>" = enabled;
          "<Left>" = enabled;
          "<Right>" = enabled;
        };
      };
    };
    oil = {
      enable = true;
      settings = {
        view_options.show_hidden = true;
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      key = "<leader>e";
      action.__raw = "function() require('oil').open() end";
    }
  ];
}
