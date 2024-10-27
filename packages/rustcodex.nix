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
    cargoHash = "sha256-SLdOmvZRe3maNahQ/whtfwKLQ8u4FaEopBeseBFPCLo=";
    src = pkgs.fetchFromGitHub {
      owner = "rkuklik";
      repo = pname;
      rev = "cde4e7a01350ec1211b28380e1dc923cac45c04b";
      hash = "sha256-YRtiPYM8YM4Dw4Y5nRmeItXNudmGQ1CoNeDNa17zELs=";
    };

    nativeBuildInputs = [installShellFiles];
    postInstall = ''
      cat Cargo.toml
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
