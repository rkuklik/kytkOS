{
  config,
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
    mkMerge
    mkOption
    mkOptionType
    removeAttrs
    types
    ;
  cfg = config.flowerbed.plasma.keybinds;
  keybinds = attrValues cfg;

  fullKeybind.options = {
    keys = mkOption {
      type = types.listOf types.str;
      default = "";
    };
    default = mkOption {
      type = types.str;
      default = "";
    };
    description = mkOption {
      type = types.str;
    };
  };
  plasmaKeybind = mkOptionType {
    name = "plasmaKeybind";
    merge = loc: defs: let
      converter = {
        value,
        file,
      }: {
        inherit file;
        value =
          if isAttrs value
          then value
          else {
            keybinds =
              if isList value
              then value
              else [value];
          };
      };
    in
      (types.submodule fullKeybind).merge loc (map converter defs);
  };

  keybindGroupOpts.options = mkOption {
    type = types.attrsOf plasmaKeybind;
  };
  keybindGroupDef.options = {
    name = mkOption {
      description = "System name";
      type = types.str;
    };
    description = mkOption {
      description = "Friendly description";
      type = types.str;
    };
  };

  bind = {
    name,
    keys,
    default,
    description,
  }: let
    escaper = escape ["," "\\"];
  in {
    inherit name;
    value = concatStringsSep "," [
      (concatStringsSep "\t" (map escaper keys))
      (escaper default)
      (escaper description)
    ];
  };
  mkKeybindGroup = {
    name,
    description,
  } @ set: let
    binds = attrValues (removeAttrs filtered (attrNames keybindGroupDef.options));
    filtered = filter (binding: binding.keys != []) binds;
    transformed = map bind filtered;
  in {
    inherit name;
    value =
      {
        _k_friendly_name = description;
      }
      // listToAttrs transformed;
  };
in {
  options.flowerbed.plasma.keybinds = mkOption {
    description = "Plasma keybindings";
    type = types.attrsOf (types.submodule [keybindGroupDef keybindGroupOpts]);
    default = {};
  };

  config.programs.plasma.configFile.kglobalshortcutsrc = mkMerge (map mkKeybindGroup keybinds);
}
