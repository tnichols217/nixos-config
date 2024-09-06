{ ... }:
let
  # linux_rpi5 = pkgs.linux_rpi4.override {
  #   rpiVersion = 5;
  #   argsOverride.defconfig = "bcm2712_defconfig";
  # };
in
{
  boot = {
    # kernelPackages = lib.mkDefault (pkgs.linuxPackagesFor linux_rpi5);
    initrd.availableKernelModules = [
      "nvme"
      "usbhid"
      "usb_storage"
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
    raspberry-pi = {
      config = {
        all = {
          base-dt-params = {
            # enable autoprobing of bluetooth driver
            # https://github.com/raspberrypi/linux/blob/c8c99191e1419062ac8b668956d19e788865912a/arch/arm/boot/dts/overlays/README#L222-L224
            krnbt = {
              enable = true;
              value = "on";
            };
          };
        };
      };
    };
  };
  raspberry-pi-nix.libcamera-overlay.enable = false;
}