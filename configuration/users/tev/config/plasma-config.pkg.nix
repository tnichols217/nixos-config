{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./combine.metapkg.nix { pack = [
  ( pkgs.callPackage ./plasma-config/autostart.pkg.nix {} )
  ( pkgs.callPackage ./plasma-config/rc.pkg.nix {} )
]; }