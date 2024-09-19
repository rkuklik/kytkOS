lib: let
  inherit
    (builtins)
    readDir
    readFileType
    ;
  inherit
    (lib)
    filter
    flatten
    hasAttr
    isString
    mapAttrs
    mapAttrsToList
    mapNullable
    match
    ;

  filetype = {
    regular = "regular";
    directory = "directory";
    symlink = "symlink";
  };

  entity = {
    directory,
    name,
    type,
  }: let
    path =
      if name != null
      then lib.path.append directory name
      else directory;
    nameSplit =
      mapNullable
      (match "^(.*)\\.(.+)$")
      name;
    base =
      mapNullable
      lib.head
      nameSplit;
    ext =
      mapNullable
      lib.last
      nameSplit;
  in
    assert hasAttr type filetype;
    assert name == null -> type == filetype.directory; {
      inherit
        directory
        name
        path
        type
        base
        ext
        ;
    };
  isEntity = entity:
    true
    && (entity ? directory)
    && (entity ? name)
    && (entity ? path)
    && (entity ? type)
    && (entity ? base)
    && (entity ? ext);
  validate = entity:
    assert isEntity entity;
    assert entity.name != null -> entity.type != filetype.directory;
    assert readFileType entity.path == entity.type; entity;

  file = directory: name:
    entity {
      inherit directory name;
      type = filetype.regular;
    };
  symlink = directory: name:
    entity {
      inherit directory name;
      type = filetype.symlink;
    };
  directory = directory:
    entity {
      inherit directory;
      name = null;
      type = filetype.directory;
    };

  loadDir = directory:
    mapAttrs
    (name: type: entity {inherit directory name type;})
    (readDir directory);

  expandWith = expander: entity:
    if entity.type == filetype.directory
    then expander (loadDir entity.path)
    else validate entity;
  expandRecursive = expandWith (mapAttrs (_: file: expandRecursive file));

  enumerate = tree: flatten (mapAttrsToList enumerateMapper tree);
  enumerateMapper = _: entity:
    if entity ? type -> !(isString entity.type)
    then enumerate entity
    else [entity];

  tree = path: expandRecursive (directory path);
  treeList = path: enumerate (tree path);

  filters = {
    nix = filter (entity: entity.ext == "nix");
  };
  transformers = {
    paths = map (entity: entity.path);
  };

  include = path: transformers.paths (filters.nix (treeList path));
in {
  inherit
    directory
    enumerate
    file
    filetype
    filters
    include
    symlink
    transformers
    tree
    treeList
    validate
    ;
}
