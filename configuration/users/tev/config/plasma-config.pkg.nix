{ pkgs, host-name, ... }:
pkgs.callPackage ../metapkgs/combine.metapkg.nix { pack = [
  ( pkgs.callPackage ./plasma-config/autostart.pkg.nix { inherit host-name; } )
  ( pkgs.callPackage ./plasma-config/rc.pkg.nix { inherit host-name; } )
]; }