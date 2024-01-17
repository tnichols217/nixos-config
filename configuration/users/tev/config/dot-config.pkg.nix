{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "dot-config";
  version = "v1.0.0";

  src = ./dot-config;

  installPhase =''

  mkdir $out

  cp -r * $out

  '';

  meta = {
    description = "My dotfiles config";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}