{
  description = "kytkOS";

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {};
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
