{ config, lib, pkgs, modulesPath, host-name, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware/usbip.nix
    ./hardware/rkvm.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true;
  # hardware.xone.enable = true;
  hardware.xpadneo.enable = true;
  services.joycond.enable = true;
  hardware.nvidia.open = if host-name == "ASUS" then true else false;
  services.blueman.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  } // (if host-name == "ROG" then {
    extraPackages = with pkgs; [
      # rocm-opencl-icd
      # rocm-opencl-runtime
    ];
  } else {});

  services = {
    ratbagd.enable = true;
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