final: prev: {
  lib = prev.lib // {
    flower = import ../lib.nix prev.lib;
  };
}
