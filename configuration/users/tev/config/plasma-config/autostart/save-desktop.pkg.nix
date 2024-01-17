{ pkgs ? import <nixpkgs> {}, app, name, ... }:
pkgs.stdenv.mkDerivation 
rec {
  pname = "get-desktop-file";
  version = "v1.0.0";

  src = ./.;

  installPhase = 
  ''

  mkdir -p $out/autostart/

  cp "${app}/share/applications/${name}.desktop" "$out/autostart/${name}.desktop"

  '';

  meta = {
    description = "Gets desktop file to autostart in Plasma";
    homepage = "https://github.com/tnichols217/nixos-config";
    # license = pkgs.stdenv.lib.licenses.gpl2;
    # platforms = pkgs.stdenv.lib.platforms.all;
  };
}