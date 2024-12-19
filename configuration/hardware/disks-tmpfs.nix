{ config, lib, pkgs, modulesPath, is-iso, persistence, host-name, ... }:

{
  fileSystems = (if is-iso then
  {
    # software
    "/nix/.rw-store" = lib.mkForce {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
      options = [ "defaults" ];
      neededForBoot = true;
    };
  } 
  else 
  {

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
    
  }) // (if host-name == "ASUS" then {
      # media
      "${persistence.media}" = {
        device = "/dev/disk/by-label/NIXMEDIA";
        fsType = "ext4";
        neededForBoot = false;
      };
    } else {}) // {
      # combine
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "defaults" "size=64G" "mode=755" ];
        neededForBoot = true;
      };

      # local data
      "${persistence.local}" = {
        device = "/dev/disk/by-label/NIXPERSIST";
        fsType = "ext4";
        neededForBoot = true;
      };

      # data
      "${persistence.data}" = {
        device = "/dev/disk/by-label/NIXDATA";
        fsType = "ext4";
        neededForBoot = true;
      };

      # bucket
      "${persistence.bucket}" = {
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
