{ config, pkgs, version, ... }:
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
      ./configuration/virtualization.nix
      ./configuration/persistence.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
    auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
   };

  services.nix-serve = {
    enable = true;
  };

  programs.steam.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
  
  environment.systemPackages = with pkgs; [
    cudatoolkit
    nano
  ];

  system.stateVersion = version;
}

