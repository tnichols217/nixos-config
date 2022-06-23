{ config, pkgs, btf, arch-theme, papirus, ... }:
{
  imports =
    [
      ./users/tev.nix
    ];
  users.mutableUsers = false;
}