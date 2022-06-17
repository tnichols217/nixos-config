{ pkgs ? import <nixpkgs> {}, pack ? [], ... }:
pkgs.stdenv.mkDerivation 
rec {
  pname = "combine";
  version = "v1.0.0";

  src = ./.;

  installPhase = 
  let
  concat = "\"" + pkgs.lib.concatStringsSep "\" \"" (pkgs.lib.lists.forEach pack ( x: toString x )) + "\"";
  in ''

  mkdir $out

  for file in ${concat}
  do
    cp -rsn $file/* $out
    ${pkgs.findutils}/bin/find $out -type d -exec chmod 755 {} +
    # chmod -R 755 $out/*
  done

  '';

  meta = {
    description = "Combines two deriviations (for config files)";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.stdenv.lib.licenses.gpl3;
    platforms = pkgs.stdenv.lib.platforms.all;
  };
}