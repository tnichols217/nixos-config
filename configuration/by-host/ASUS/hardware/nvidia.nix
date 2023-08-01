
{ pkgs, attrs, config, ... }:
{
  hardware.nvidia = {
    prime.nvidiaBusId = "PCI:1:0:0";
    modesetting.enable = true;
  };
}