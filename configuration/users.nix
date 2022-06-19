{ config, pkgs, impermanence, home-manager, btf, arch-theme, papirus, nur, ... }:
{
  imports =
    [
      home-manager.nixosModule
      ./users/tev.nix
    ];
  users.mutableUsers = false;
}