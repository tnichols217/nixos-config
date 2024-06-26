{ config, pkgs, version, host-name, oldnixpkgs, addresses, persistence, ... }:
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
      ./configuration/programs.nix
    ];

  systemd.tmpfiles.rules = [
    "d /etc/nix/ 0777 root root"
    "d /home 0755 root users"
    "z /home 0755 root users"
    "d /${persistence.default} 0777 root root"
  ];

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
    '';
    settings = {
      trusted-substituters = [
        "https://cache.garnix.io"
        "https://cache.nixos.org/"
        "https://raspberry-pi-nix.cachix.org"
        "https://tnichols217-nixos-config.cachix.org"
        "https://${addresses.default}:5000/"
      ];
      trusted-public-keys = [
        "tnichols217-nixos-config.cachix.org-1:B9JhBiPS+OHykLW16qovoOelAvtdH5sIjYU7BZvs7q8="
        "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
        "${addresses.default}:lT5jwGHgyaGJkTJtl/pTN4GqLSSkC/siY0EAfDoGpjo="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
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
    zsh.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
  
  environment.systemPackages = with pkgs; [
    nano
    btrfs-progs
    zrok
    bridge-utils
  ];

  system.stateVersion = version;
}

