{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "doas-wrapper";
  version = "v1.0.0";

  src = ./.;

  installPhase =''

  mkdir -p $out/bin

  cp -sr ${pkgs.doas} $out
  cp -sr ${pkgs.doas + "/bin/doas"} $out/bin/sudo

  '';

  meta = {
    description = "Wraps doas as the sudo command";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}