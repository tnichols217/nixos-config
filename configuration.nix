{ config, pkgs, version, host-name, oldnixpkgs, addresses, persistence, ... }:
{
  imports = [
    ./configuration/hardware.nix
    ./configuration/filesystems.nix
    ./configuration/kernel.nix
    ./configuration/bootloader.nix
    ./configuration/network.nix
    ./configuration/localization.nix
    ./configuration/users.nix
    ./configuration/userspace.nix
    ./configuration/sound.nix
    ./configuration/security.nix
    ./configuration/nix.nix
    ./configuration/virtualization.nix
    ./configuration/persistence.nix
    ./configuration/by-host.nix
    ./configuration/programs.nix
  ];

  system.stateVersion = version;
}

