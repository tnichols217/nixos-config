{ config, pkgs, ... }:
# let
#   # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
#   # home-manager = pkgs.home-manager;
# in
{
  imports =
    [
      <home-manager/nixos>
      ./tev.nix
    ];
  users.mutableUsers = false;
}