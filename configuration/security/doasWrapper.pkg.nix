{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "doas-wrapper";
  version = "v1.0.0";

  src = ./.;

  installPhase =''

  mkdir $out

  ls ${pkgs.sudo + "/bin"}

  cp -s ${pkgs.sudo + "/bin/sudo"} $out/bin/doas

  '';

  meta = {
    description = "Wraps doas as the sudo command";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}