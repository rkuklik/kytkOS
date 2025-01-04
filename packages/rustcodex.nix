{
  lib,
  pkgs,
  rustPlatform,
  installShellFiles,
}:
let
  pname = "rustcodex";
in
rustPlatform.buildRustPackage {
  inherit pname;
  version = "0.0.0";
  cargoHash = "sha256-1nCaEIzQmd1X0ZbpRxsah6icF+DHP3eDUBKkN+YiRF0=";
  src = pkgs.fetchFromGitHub {
    owner = "rkuklik";
    repo = pname;
    rev = "9db7deeadf395e0044758e1718f26b2e3620d9cf";
    hash = "sha256-4sV9Jc4TSgHkRX2zoIIR2joiPeriiqaWg/oQ+2+GNt0=";
  };

  nativeBuildInputs = [ installShellFiles ];
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
    platforms = lib.platforms.all;
  };
}
