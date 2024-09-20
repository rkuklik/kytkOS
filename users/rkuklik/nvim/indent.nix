{
  programs.nixvim.plugins = {
    indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        scope.enabled = false;
      };
    };
    mini = {
      enable = true;
      modules = {
        indentscope = {
          draw = {
            animation.__raw =
              # lua
              ''
                require("mini.indentscope").gen_animation.quadratic({
                  easing = "out",
                  duration = 20,
                  unit = "step",
                })
              '';
          };
          symbol = "│";
          options = {
            try_as_border = true;
          };
        };
      };
    };
  };
}
