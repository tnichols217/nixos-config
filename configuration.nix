{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./bootloader.nix
      ./network.nix
      ./localization.nix
      ./users/users.nix
      ./x11/x11.nix
    ];


  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    konsole
    nano
    wget
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

