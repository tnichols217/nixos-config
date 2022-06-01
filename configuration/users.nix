{ config, pkgs, impermanence, ... }:
let
  # impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [
      # (import "${impermanence}/nixos.nix")
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