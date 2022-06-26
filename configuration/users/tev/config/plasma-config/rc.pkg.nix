{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ../../metapkgs/build-config.metapkg.nix { config-set = (pkgs.callPackage ./rc/config.nix { }); }