{ pkgs, host-name, addresses, inputs, ... }:
pkgs.callPackage ../metapkgs/combine.metapkg.nix { pack = [
  ( pkgs.callPackage ./plasma-config/autostart.pkg.nix { inherit host-name inputs; } )
  ( pkgs.callPackage ./plasma-config/rc.pkg.nix { inherit host-name addresses; } )
]; }