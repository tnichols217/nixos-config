{ config, pkgs, ... }:
# let
#   home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
# in
{
  imports =
    [
      (import "${pkgs.home-manager}/nixos")
      ./tev.nix
    ];
  users.mutableUsers = false;
}