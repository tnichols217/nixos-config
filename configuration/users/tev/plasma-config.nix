{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "plasma-config";
  version = "v1.0.0";

  src = ./plasma_config;

  installPhase =''

  ${pkgs.python3}/bin/python export.py
  ${pkgs.bash}/bin/bash config.sh ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5

  cp -r ./conf/* $out/

  '';

  meta = {
    description = "My personal KDE plasma configuration";
    homepage = "https://github.com/tnichols217/nixos-config";
    # license = pkgs.stdenv.lib.licenses.gpl2;
    # platforms = pkgs.stdenv.lib.platforms.all;
  };
}