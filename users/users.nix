{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  nur = builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
      ./tev.nix
    ];
  users.mutableUsers = false;
}