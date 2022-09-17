{ config, pkgs, ... }:
{
  imports =
    [
      ./users/tev.nix
      ./users/root.nix
    ];
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.fish;
}