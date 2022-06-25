{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ../../metapkgs/build-config.metapkg.nix { config-set = (import ./rc/config.nix { inherit pkgs; }); }