{ config, pkgs, ... }:
{
  imports =
    [
      ./configuration/disks-tmpfs.nix
      # ./configuration/disks.nix
      ./configuration/bootloader.nix
      ./configuration/network.nix
      ./configuration/localization.nix
      ./configuration/users.nix
      ./configuration/x11.nix
      ./configuration/sound.nix
      ./configuration/ssh.nix
      ./configuration/security.nix
      ./configuration/persistence.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
   };

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
  
  environment.systemPackages = with pkgs; [
    nano
    (pkgs.callPackage ./configuration/security/doasWrapper.pkg.nix {})
  ];

  system.stateVersion = "21.11";
}

