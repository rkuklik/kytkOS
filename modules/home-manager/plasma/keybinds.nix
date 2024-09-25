{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    attrNames
    concatStringsSep
    escape
    filterAttrs
    isList
    listToAttrs
    mapAttrs
    mkOption
    types
    ;
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

  stripper = name: value: !(name == "name" || name == "description");
  toOption = set: mapAttrs (_: _: keybindOpt) (filterAttrs stripper set);
  opts = mapAttrs (_: toOption) mappings;
in {
  options.flowerbed.plasma.keybinds = opts;

  config.programs.plasma.configFile.kglobalshortcutsrc = shortcuts;
}
