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
    cargoHash = "sha256-lkcAUGf93A0ddzKbJwvjdVdhg9h5xcBNHabkU6fRTvI=";
    src = pkgs.fetchFromGitHub {
      owner = "rkuklik";
      repo = pname;
      rev = "66b26ba3bb7d8db974e39a60e6199b8645e7aa14";
      hash = "sha256-bByRhLpcCcs7NUkru14zPC4hq+LDvNVx8f2Tu4mklIQ=";
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
