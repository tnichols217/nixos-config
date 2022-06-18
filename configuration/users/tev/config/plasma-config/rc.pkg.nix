{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./build-config.metapkg.nix { config = import ./rc/config.nix { inherit pkgs; }; }