{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems = {
    # combine
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
      neededForBoot = true;
    };

    # software
    "/nix" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
      neededForBoot = true;
    };

    # boot
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      neededForBoot = true;
    };

    # local data
    "/nix/persist" = {
      device = "/dev/disk/by-label/NIXPERSIST";
      fsType = "ext4";
      neededForBoot = true;
    };

    # data
    "/nix/persist/etc/nixos/configuration/persistence/data" = {
      device = "/dev/disk/by-label/NIXDATA";
      fsType = "ext4";
      neededForBoot = true;
    };

    # bucket
    "/nix/persist/etc/nixos/configuration/persistence/bucket" = {
      device = "/dev/disk/by-label/NIXBUCKET";
      fsType = "ext4";
      neededForBoot = true;
    };
  };

  swapDevices = [
    { 
      # swap
      device = "/dev/disk/by-label/NIXSWAP";
    }
  ];
}
