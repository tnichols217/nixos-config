{ config, pkgs, ... }:
{
  imports =
    [
      ./plasma5.nix
    ];
  services.xserver.enable = true;
  services.printing.enable = true;
  services.xserver.libinput.enable = true;
}