{ pkgs, lib, ... }:
let
  # linux_rpi5 = pkgs.linux_rpi4.override {
  #   rpiVersion = 5;
  #   argsOverride.defconfig = "bcm2712_defconfig";
  # };
in
{
  boot = {
    loader = {
      grub.enable = false;
    };

    consoleLogLevel = lib.mkDefault 7;
    kernelParams = [
      "console=tty1"
      # https://github.com/raspberrypi/firmware/issues/1539#issuecomment-784498108
      "console=serial0,115200n8"
    ];

    kernelPackages = pkgs.linuxPackages_rpi4;
    initrd.availableKernelModules = [
      "pcie_brcmstb" # required for the pcie bus to work
      "reset-raspberrypi" # required for vl805 firmware to load
      "usb_storage"
      "usbhid"
      "vc4"
      "nvme"
      "xhci_pci"
      "ahci"
      "virtio_pci"
      "btrfs"
      "usbip_host"
      "sdhci_pci"
    ];
  };

  hardware = {
    bluetooth.enable = true;
  };
}