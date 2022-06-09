
{ pkgs, kconfig }:

pkgs.stdenv.mkDerivation rec {
  pname = "plasma-config";

  src = ./plasma_config;

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

  ${pkgs.python3}/bin/python export.py
  ${pkgs.bash-interactive}/bin/bash config.sh ${kconfig}/bin/kwriteconfig5

  cp -r ./conf/* $out/

  '';

  meta = {
    description = "My personal KDE plasma configuration";
    homepage = "https://github.com/tnichols217/nixos-config";
    # license = pkgs.stdenv.lib.licenses.gpl2;
    # platforms = pkgs.stdenv.lib.platforms.all;
  };
}