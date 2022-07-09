{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    # combine
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
    };

    # software
    "/nix" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

    # boot
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

    # local data
    "/nix/persist" = {
      device = "/dev/disk/by-label/NIXPERSIST";
      fsType = "ext4";
    };

    # data
    "/nix/persist/etc/nixos/configuration/persistence/data/home" = {
      device = "/dev/disk/by-label/NIXDATA";
      fsType = "ext4";
    };

    # bucket
    "/nix/persist/etc/nixos/configuration/persistence/bucket/home" = {
      device = "/dev/disk/by-label/NIXBUCKET";
      fsType = "ext4";
    };
  };



  swapDevices = [
    { 
      # swap
      device = "/dev/disk/by-label/NIXSWAP";
    }
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
