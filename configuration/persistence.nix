{ config, pkgs, ... }:
let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{
  imports =
    [
      (import "${impermanence}/nixos.nix")
      ./persistence/cache.nix
      # ./persistence/config.nix
      # ./persistence/data.nix
    ];
  environment.persistence."/nix/persist" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
  };
}