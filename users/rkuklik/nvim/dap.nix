{
  programs.nixvim.plugins = {
    dap = {
      enable = true;
      extensions.dap-ui = {
        enable = true;
      };
    };
    dap-lldb = {
      enable = true;
    };
  };
}
