{ pkgs }:
pkgs.stdenv.mkDerivation 
rec {
  pname = "background";
  version = "v1.0.0";

  src = ./background;

  installPhase = ''

  mkdir $out

  cp * $out

  '';

  meta = {
    description = "Saves my backgrounds to the nix store";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}