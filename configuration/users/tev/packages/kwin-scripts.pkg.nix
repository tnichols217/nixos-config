{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "kwin-scripts";
  version = "1.0";

  src = ./kwin-scripts;

  installPhase =''

  mkdir -p $out/share/kwin/scripts/${pname}
  mkdir -p $out/share/kservices5
  cp -r ./* $out/share/kwin/scripts/${pname}
  ln -s $out/share/kwin/scripts/${pname}/metadata.desktop $out/share/kservices5/kwin-script-grid-tiling.desktop

  echo $out

  '';

  meta = {
    description = "My personal KDE plasma configuration";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}