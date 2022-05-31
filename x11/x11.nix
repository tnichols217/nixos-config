{ config, pkgs, ... }:
{
  imports =
    [
      ./plasma5.nix
    ];
  services.xserver.enable = true;
  services.printing.enable = true;
  sound.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.xserver.libinput.enable = true;
}