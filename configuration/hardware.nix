{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware/disks-tmpfs.nix
    ./hardware/usbip.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "virtio_pci" "sr_mod" "virtio_blk" "usb_storage" "usbhid" "rtsx_usb_sdmmc" "btrfs" "usbip_host" "sdhci_pci" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true;

  services = {
    ratbagd.enable = true;
    xserver.libinput = {
      mouse = {
        scrollMethod = "button";
        scrollButton = 3;
      };
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
      };
    };

  };

}