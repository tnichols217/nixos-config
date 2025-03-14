{ config, pkgs, ... }:
{
  imports =
    [
      ./users/tev.nix
      ./users/soda.nix
      ./users/root.nix
    ];
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  services.logind.extraConfig = "RuntimeDirectorySize=100%";
}