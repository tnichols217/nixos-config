{ config, lib, pkgs, modulesPath, is-iso, persistence, host-name, ... }:

{
  fileSystems = {
    # software
    # "/nix/.rw-store" = lib.mkForce {
    #   device = "/dev/disk/by-label/NIXROOT";
    #   fsType = "ext4";
    #   options = [ "defaults" ];
    #   neededForBoot = true;
    # };

    "/nix/.rw-store" = lib.mkForce {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=16G" "mode=755" ];
      neededForBoot = true;
    };

    "/nix/store" = lib.mkForce {
      fsType = "overlay";
      device = "overlay";
      options = [
        "lowerdir=/nix/.ro-store/nix/store"
        "upperdir=/nix/.rw-store/store"
        "workdir=/nix/.rw-store/work"
      ];
      depends = [
        "/nix/.ro-store/nix/store"
        "/nix/.rw-store/store"
        "/nix/.rw-store/work"
      ];
    };

    "/" = lib.mkForce {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
      neededForBoot = true;
    };

    # local data
    "${persistence.local}" = {
      neededForBoot = true;
    };

    # data
    "${persistence.default}" = {
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
