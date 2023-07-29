{ config, pkgs, ... }:
{
  imports =
    [
      ./x11/plasma5.nix
    ];
  services.xserver.enable = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;
  services.printing.drivers = [ pkgs.gutenprintBin pkgs.hplipWithPlugin pkgs.brgenml1lpr pkgs.brgenml1cupswrapper pkgs.cnijfilter2 ];
  services.xserver.libinput.enable = true;
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    enableDefaultPackages = true;
  };
}