{ config, pkgs, version, host-name, attrs, ... }:
{
  imports =
    [
      ./configuration/hardware.nix
      ./configuration/bootloader.nix
      ./configuration/network.nix
      ./configuration/localization.nix
      ./configuration/users.nix
      ./configuration/x11.nix
      ./configuration/sound.nix
      ./configuration/security.nix
      ./configuration/ssh.nix
      ./configuration/virtualization.nix
      ./configuration/persistence.nix
      ./configuration/by-host.nix
      ./configuration/flatpak.nix
    ];

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''experimental-features = nix-command flakes'';
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://tnichols217-nixos-config.cachix.org"
      ];
      trusted-public-keys = [
        "tnichols217-nixos-config.cachix.org-1:B9JhBiPS+OHykLW16qovoOelAvtdH5sIjYU7BZvs7q8="
      ];
      auto-optimise-store = true;
      trusted-users = [ "tev" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  programs = {
    steam.enable = true;
    fish.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "python-2.7.18.6"
      ];
    };
  };
  nixpkgs.config = {
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
  
  environment.systemPackages = with pkgs; [
    nano
    btrfs-progs
  ];

  system.stateVersion = version;
}

