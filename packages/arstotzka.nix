{
  stdenv,
  lib,
  pkgs,
  extra-cmake-modules,
  kdePackages,
  libsForQt5,
  qt6,
}: let
  pname = "arstotzka";
in
  stdenv.mkDerivation {
    inherit pname;
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "rkuklik";
      repo = pname;
      rev = "7d8c7bb692790dd7b1ca0f5d6ea321a77f4c49fd";
      hash = "sha256-2fJSoNKTj7UnL3HcHjbTE2jlGyiuYz3DpvNjPJ4Y+dg=";
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
      license = lib.licenses.gpl3Plus;
      inherit (libsForQt5.plasma-framework.meta) platforms;
    };
  }
