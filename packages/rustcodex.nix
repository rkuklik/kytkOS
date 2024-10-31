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
      rev = "77c7f58c5334dec4a0bf78a106dbfe62dfe522a7";
      hash = "sha256-zQraVWkuplBMlFOxC2nqXKFdTadrV9lBAlmHJjbDO5o=";
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
