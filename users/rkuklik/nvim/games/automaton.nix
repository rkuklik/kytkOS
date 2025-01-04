{
  pkgs,
  config,
  lib,
  ...
}:
let
  animations = {
    slide = {
      fps = 50;
      update =
        # lua
        ''
          function(grid)
            for i = 1, #grid do
              local prev = grid[i][#grid[i]]
              for j = 1, #grid[i] do
                grid[i][j], prev = prev, grid[i][j]
              end
            end
            return true
          end
        '';
    };
    screensaver = {
      fps = 50;
      update =
        # lua
        ''
          function(grid)
            screensaver(grid, function(prev, i, j)
              grid[i][j], prev = prev, grid[i][j]
              return prev
            end)
            return true
          end
        '';
    };
    screensaver-inplace-hl = {
      fps = 50;
      update =
        # lua
        ''
          function(grid)
            screensaver(grid, function(prev, i, j)
              grid[i][j].char, prev.char = prev.char, grid[i][j].char
              return prev
            end)
            return true
          end
        '';
    };
    screensaver-inplace-char = {
      fps = 50;
      update =
        # lua
        ''
          function(grid)
            screensaver(grid, function(prev, i, j)
              grid[i][j].hl_group, prev.hl_group = prev.hl_group, grid[i][j].hl_group
              return prev
            end)
            return true
          end
        '';
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.cellular-automaton-nvim ];
    plugins.treesitter.enable = true;
    extraConfigLua =
      let
        inherit (lib)
          attrValues
          mapAttrs
          ;
        converted = attrValues (
          mapAttrs (
            name:
            {
              fps ? 30,
              update,
            }:
            {
              inherit name fps;
              update.__raw = update;
            }
          ) animations
        );
      in
      # lua
      ''
        do
          local screensaver = function(grid, swapper)
            local get_character_cols = function(row)
              local cols = {}
              for i = 1, #row do
                if row[i].char ~= " " then table.insert(cols, i) end
              end
              return cols
            end

            for i = 1, #grid do
              local cols = get_character_cols(grid[i])
              if #cols > 0 then
                local last_col = cols[#cols]
                local prev = grid[i][last_col]
                for _, j in ipairs(cols) do
                  prev = swapper(prev, i, j)
                end
              end
            end
          end
          local animations = ${config.lib.nixvim.toLuaObject converted}
          local automaton = require("cellular-automaton")
          for _, animation in ipairs(animations) do
            automaton.register_animation(animation)
          end
        end
      '';
  };
}
