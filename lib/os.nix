lib:
let
  systems = {
    linux = {
      x86_64 = "x86_64-linux";
      aarch64 = "aarch64-linux";
    };
    darwin = {
      x86_64 = "x86_64-darwin";
      aarch64 = "aarch64-darwin";
    };
  };
in
{
  inherit
    systems
    ;
}
