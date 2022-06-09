{ config, pkgs, impermanence, ... }:
let
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/684e85d01d333be91c4875baebb05b93c7d2ffaa.tar.gz";
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