{ config, pkgs, impermanence, home-manager, btf, arch-theme, papirus, nur, ... }:
{
  imports =
    [
      (import "${home-manager}/nixos")
      ./users/tev.nix
    ];
  users.mutableUsers = false;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import nur {
      inherit pkgs;
    };
  };
}