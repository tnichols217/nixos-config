{ config, pkgs, impermanence, ... }:
let
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/20703892473d01c70fb10248442231fe94f4ceb4.tar.gz";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/64ab7d6e8d157848ec285cd267db29e2f14c1076.tar.gz";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
      ./users/tev.nix
    ];
  users.mutableUsers = false;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
}