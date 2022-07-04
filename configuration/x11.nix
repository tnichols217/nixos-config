{ config, pkgs, ... }:
{
  imports =
    [
      ./x11/plasma5.nix
    ];
  services.xserver.enable = true;
  services.printing.enable = true;
  services.xserver.libinput.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.opengl.enable = true;
}