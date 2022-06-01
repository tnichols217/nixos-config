{ config, pkgs, ... }:
{
  imports =
    [
      ./configuration/hardware-configuration.nix
      ./configuration/bootloader.nix
      ./configuration/network.nix
      ./configuration/localization.nix
      ./configuration/users.nix
      ./configuration/x11.nix
      ./configuration/sound.nix
      ./configuration/persistence.nix
    ];

  nix.autoOptimiseStore = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "daily";
  };

  system.autoUpgrade.rebootWindow.lower = "04:00";
  system.autoUpgrade.rebootWindow.upper = "05:00";
  
  environment.systemPackages = with pkgs; [
    nano
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh.enable = true;

  # man configuration.nix or on https://nixos.org/nixos/options.html
  system.stateVersion = "21.11";

}

