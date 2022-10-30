{ config, pkgs, ... }:
{
  imports =
    [
      ./x11/plasma5.nix
    ];
  services.xserver.enable = true;
  services.printing.enable = true;
  services.xserver.libinput.enable = true;
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  fonts = {
    fonts = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    enableDefaultFonts = true;
  };
}