{ pkgs, arch-theme, btf, arch-theme, papirus, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "arch-kde-theme";
  version = "14ab5e53e6fe6b18ffcaba2194c8748e858e6024";

  # src = arch-theme;
  src = ./.;

  installPhase = let 
    SCHEMES_DIR = "$PREFIX/color-schemes";
    PLASMA_DIR = "$PREFIX/plasma/desktoptheme";
    LOOKFEEL_DIR = "$PREFIX/plasma/look-and-feel";
    KVANTUM_DIR = "$PREFIX/Kvantum";
    KONSOLE_DIR = "$PREFIX/konsole";
    SRC_DIR = src;
    DARK_THEME_DIR = "${PLASMA_DIR}/Arch-dark/colors";
    LIGHT_THEME_DIR = "${PLASMA_DIR}/Arch/colors";
  in
  ''
  #!/bin/bash

  PREFIX="$out/share"
  echo $out

  mkdir -p ${SCHEMES_DIR}
  mkdir -p ${DARK_THEME_DIR}
  mkdir -p ${LIGHT_THEME_DIR}
  mkdir -p ${LOOKFEEL_DIR}
  mkdir -p ${KVANTUM_DIR}
  mkdir -p ${KONSOLE_DIR}

  cp -r color-schemes/*.colors                                            ${SCHEMES_DIR}
  cp -r Kvantum/*                                                         ${KVANTUM_DIR}
  cp -r konsole/*                                                         ${KONSOLE_DIR}
  cp -r plasma/desktoptheme/*                                             ${PLASMA_DIR}
  cp -r color-schemes/Arch.colors                                         ${LIGHT_THEME_DIR}
  cp -r color-schemes/ArchDark.colors                                     ${DARK_THEME_DIR}
  cp -r plasma/look-and-feel/*                                            ${LOOKFEEL_DIR}

  '';

  meta = {
    description = "A Customized beautiful theme for KDE based distros";
    homepage = "https://github.com/rkstrdee/Arch";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}