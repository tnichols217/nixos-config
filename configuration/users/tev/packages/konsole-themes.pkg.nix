{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ../metapkgs/build-config.metapkg.nix { config-set = (import ./konsole-themes/config.nix { inherit pkgs; }); }