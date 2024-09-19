lib: let
  inherit
    (builtins)
    map
    listToAttrs
    ;

  bootstrap = import ./lib/fs.nix lib;
  modules = bootstrap.filters.nix (bootstrap.treeList ./lib);

  named = entity: {
    name = entity.base;
    value = import entity.path lib;
  };
  namespaced = map named modules;
in
  listToAttrs
  namespaced
