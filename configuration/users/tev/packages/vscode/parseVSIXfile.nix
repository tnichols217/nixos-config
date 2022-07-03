{ pkgs, file }:

pkgs.stdenv.mkDerivation rec {
  pname = "vscodeExtensionRenamer";
  version = "v1.0.0";

  src = arch-theme;

  installPhase = 
  ''
  #!/bin/bash

  mkdir $out

  cp ${file} $out

  cd $out
  mv * extension.zip

  '';

  meta = {
    description = "A Customized beautiful theme for KDE based distros";
    homepage = "https://github.com/rkstrdee/Arch";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
} + "/extension.zip"