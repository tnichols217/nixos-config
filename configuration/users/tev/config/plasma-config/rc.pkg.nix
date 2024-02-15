{ pkgs ? import <nixpkgs> {}, host-name, addresses, ... }:
pkgs.callPackage ../../metapkgs/build-config.metapkg.nix { config-set = (import ./rc/config.nix { inherit pkgs host-name addresses; }); }