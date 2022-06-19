{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ../../metapkgs/build-config.metapkg.nix { config = import ./rc/config.nix { inherit pkgs; }; }