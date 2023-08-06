{ pkgs ? import <nixpkgs> {}, attr, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "dot-config";
  version = "v1.0.0";

  src = pkgs.kitty;

  installPhase =''

  mkdir $out

  cp -r * $out

  cd $out/bin

  mv kitty kitty-unwrapped
  cp ${pkgs.writeShellScriptBin "kitty" "${pkgs.kitty}/bin/kitty -c ~/.config/kitty/kitty.conf -c $(ls ${"${attrs.kitty-themes}/themes"} | shuf -n 1) $argv"}/bin/* .

  '';

  meta = {
    description = "my kitty randomizer";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}