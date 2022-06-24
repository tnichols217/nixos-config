{ pkgs ? import <nixpkgs> {}, config ? ../config/plasma-config/rc/config.nix, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "plasma-config";
  version = "v1.0.0";

  src = ./build-config;

  installPhase =''

  echo $out

  cp ${builtins.toFile "config.json" (builtins.toJSON (import config { inherit pkgs; }))} ./config.json

  ${pkgs.python3}/bin/python export.py
  ${pkgs.bash}/bin/bash config.sh ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5

  mkdir -p $out
  cp -r ./conf/* $out

  '';

  meta = {
    description = "My personal KDE plasma configuration";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}