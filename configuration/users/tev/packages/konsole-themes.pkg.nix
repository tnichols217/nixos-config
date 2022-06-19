{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ../metapkgs/build-config.metapkg.nix { config = import ./konsole-themes/config.nix { inherit pkgs; }; }