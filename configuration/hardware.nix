{ config, lib, pkgs, modulesPath, host-name, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware/disks-tmpfs.nix
    ./hardware/usbip.nix
    ./hardware/rkvm.nix
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "virtio_pci" "sr_mod" "virtio_blk" "usb_storage" "usbhid" "rtsx_usb_sdmmc" "btrfs" "usbip_host" "sdhci_pci" ];
  boot.initrd.kernelModules = if host-name == "ASUS" then [ "nvidia" ] else [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; if host-name == "ASUS" then [
    nvidia_x11
  ] else [
    # v4l2loopback # broken for now
  ];
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true;
  hardware.xone.enable = true;
  # hardware.xpadneo.enable = true;
  services.joycond.enable = true;
  hardware.nvidia.open = if host-name == "ASUS" then true else false;
  services.blueman.enable = true;
  services.power-profiles-daemon.enable = true;

  # powerManagement.powertop.enable = true;

  services = {
    ratbagd.enable = true;
    # xserver = {
    #   digimend.enable = true;
    # };
    libinput = {
      enable = true;
      mouse = {
        scrollMethod = "button";
        scrollButton = 3;
        accelProfile = "flat";
      };
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
        tappingButtonMap = "lrm";
      };
    };
  };
}