{ ... }:
let
  linux_rpi5 = pkgs.linux_rpi4.override {
    rpiVersion = 5;
    argsOverride.defconfig = "bcm2712_defconfig";
  };
in
{
  boot = {
    kernelPackages = lib.mkDefault (pkgs.linuxPackagesFor linux_rpi5);
    initrd.availableKernelModules = [
      "nvme"
      "usbhid"
      "usb_storage"
    ];
  };
}