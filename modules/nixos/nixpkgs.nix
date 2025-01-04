{
  flower,
  inputs,
  ...
}:
let
  overlays = flower.fs.include ../../overlays;
  stdlib = final: prev: {
    lib = prev.lib // {
      inherit flower;
    };
  };
in
{
  nixpkgs.overlays = [
    stdlib
    inputs.rust.overlays.default
  ] ++ map import overlays;
}
