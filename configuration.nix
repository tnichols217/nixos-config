{ config, pkgs, version, host-name, attrs, oldnixpkgs, ... }:
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

  systemd.tmpfiles.rules = [ "d /etc/nix/ 0755 root root" ];

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
        "https://tnichols217-nixos-config.cachix.org"
        # "https://pigsgo.mooo.com:5000/"
        "https://tln32asus.student.cwru.edu:5000/"
      ];
      trusted-public-keys = [
        "tnichols217-nixos-config.cachix.org-1:B9JhBiPS+OHykLW16qovoOelAvtdH5sIjYU7BZvs7q8="
        "tln32asus.student.cwru.edu:V8MCTN/ox+Y5GxqFsjAml4IfcUvTacLFIqw48A9Ic/o="
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

