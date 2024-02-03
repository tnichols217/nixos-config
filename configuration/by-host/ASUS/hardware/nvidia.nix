
{ pkgs, attrs, config, ... }:
{
  hardware.nvidia = {
    prime.nvidiaBusId = "PCI:1:0:0";
    modesetting.enable = true;
    open = false;
    
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}