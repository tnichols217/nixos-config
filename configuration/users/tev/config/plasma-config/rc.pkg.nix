{ pkgs ? import <nixpkgs> {}, host-name, ... }:
pkgs.callPackage ../../metapkgs/build-config.metapkg.nix { config-set = (pkgs.callPackage ./rc/config.nix { inherit host-name; }); }