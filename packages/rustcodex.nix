{
  lib,
  pkgs,
  rustPlatform,
  installShellFiles,
}: let
  pname = "rustcodex";
in
  rustPlatform.buildRustPackage {
    inherit pname;
    version = "0.0.0";
    cargoHash = "sha256-jc/f5s6ALUbayTjKG6KKhwfeaNmTDUkc4HJZkCct4Gc=";
    src = pkgs.fetchFromGitHub {
      owner = "rkuklik";
      repo = pname;
      rev = "35a7a753a4a3dbd36f81cbcc33bd994921967d2a";
      hash = "sha256-pdO4q96qTjRuE7CXOo6eQyiaObRMqmoPnj4qNMbfr+0=";
    };

    nativeBuildInputs = [installShellFiles];
    postInstall = ''
      installShellCompletion \
        --bash completions/${pname}.bash \
        --fish completions/${pname}.fish \
        --zsh completions/_${pname}
    '';

    meta = {
      description = "ReCodEx solution smuggler";
      homepage = "https://github.com/rkuklik/${pname}";
      license = lib.licenses.gpl3Plus;
    };
  }
