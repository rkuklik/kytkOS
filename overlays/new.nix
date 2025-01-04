final: prev:
let
  inherit (prev)
    lib
    callPackage
    ;
  inherit (lib)
    flower
    listToAttrs
    ;
  package = entity: {
    name = entity.base;
    value = callPackage entity.path { };
  };
  packages = flower.fs.treeList ../packages;
in
listToAttrs (map package packages)
