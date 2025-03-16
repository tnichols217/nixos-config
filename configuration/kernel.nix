{ config, pkgs, host-name, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "virtio_pci" "sr_mod" "virtio_blk" "usb_storage" "usbhid" "rtsx_usb_sdmmc" "btrfs" "usbip_host" "sdhci_pci" ];
      kernelModules = if host-name == "ASUS" then [ "nvidia" ] else [ "amdgpu" ];
    };
    kernelModules = [ "kvm-intel" "kvm-amd" ];
    extraModulePackages = with config.boot.kernelPackages; if host-name == "ASUS" then [
      nvidia_x11
    ] else [
      # v4l2loopback # broken for now
    ];
    supportedFilesystems = [ "ntfs" "btrfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
}