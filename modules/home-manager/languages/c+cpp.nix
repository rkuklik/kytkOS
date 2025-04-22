{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.flowerbed.languages.c-cpp;
in
{
  options.flowerbed.languages.c-cpp = {
    enable = mkEnableOption "C and C++";
  };
  config = {
    home = {
      packages = mkIf cfg.enable [ pkgs.gcc ];
      file.".clang-format".text =
        # yaml
        ''
          Language: Cpp
          BasedOnStyle: Chromium
          Standard: c++17

          ColumnLimit: 80
          IndentWidth: 4
          TabWidth: 4
          ContinuationIndentWidth: 4
          UseTab: Never

          AlignAfterOpenBracket: BlockIndent
          BinPackArguments: false
          BinPackParameters: false
          BreakAfterReturnType: All
          AccessModifierOffset: -2
        '';
    };
  };
}
