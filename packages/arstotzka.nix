{
  stdenv,
  lib,
  pkgs,
  extra-cmake-modules,
  kdePackages,
  qt6,
}:
let
  pname = "arstotzka";
in
stdenv.mkDerivation {
  inherit pname;
  version = "1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "rkuklik";
    repo = pname;
    rev = "7ffc018fec3bcba219e89c38250eacb41e191510";
    hash = "sha256-B44FUZ8YEGHfAfmHF3ZXr3JtzPgvKToFEfkTfmBhiY8=";
  };

  nativeBuildInputs = [
    extra-cmake-modules
    qt6.wrapQtAppsHook
  ];
  buildInputs = with kdePackages; [
    qt6.qtbase
    kconfig
    kconfigwidgets
    kcoreaddons
    kdecoration
  ];
  cmakeFlags = [
    "-DQT_MAJOR_VERSION=6"
  ];

  meta = {
    description = "Simple border for KDE Plasma 6";
    homepage = "https://github.com/rkuklik/${pname}";
    license = lib.licenses.gpl3Plus;
    inherit (kdePackages.kdecoration.meta) platforms;
  };
}
