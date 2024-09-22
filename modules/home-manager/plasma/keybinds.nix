{
  config,
  options,
  lib,
  ...
}: let
  inherit
    (lib)
    attrNames
    attrValues
    concatStringsSep
    escape
    filter
    isAttrs
    isList
    listToAttrs
    mapAttrs
    mkOption
    removeAttrs
    types
    ;
  opts = options.flowerbed.plasma.keybinds;
  cfg = config.flowerbed.plasma.keybinds;
  groupNames = attrNames cfg;

  escaper = escape ["," "\\"];
  mkKeybind = {
    command,
    description,
    default ? "",
  }: keys: {
    name = command;
    value = concatStringsSep "," [
      (concatStringsSep "\t" (map escaper keys))
      (escaper default)
      (escaper description)
    ];
  };
  mkKeybindGroup = name: let
    definition = mappings.${name};
    group = cfg.${name};
    optionNames = attrNames group;
    keybinds = map (option: mkKeybind definition.${option} group.${option}) optionNames;
  in {
    name = definition.name;
    value =
      {
        _k_friendly_name = definition.description;
      }
      // listToAttrs keybinds;
  };

  shortcuts = listToAttrs (map mkKeybindGroup groupNames);

  mappings = {
    kwin = {
      name = "kwin";
      description = "KWin";
      fullscreen = {
        command = "Window Fullscreen";
        description = "Make Window Fullscreen";
      };
      close = {
        command = "Window Close";
        description = "Close Window";
        default = "Alt+F4";
      };
    };
  };

  keybindOpt = mkOption {
    description = "Keybind or list of keybinds";
    type = types.nullOr (types.oneOf [types.str (types.listOf types.str)]);
    apply = thing:
      if thing == null
      then ["none"]
      else if isList thing
      then thing
      else [thing];
  };
in {
  options.flowerbed.plasma.keybinds = {
    kwin = {
      fullscreen = keybindOpt;
      close = keybindOpt;
    };
  };

  config.programs.plasma.configFile.kglobalshortcutsrc = shortcuts;
}
