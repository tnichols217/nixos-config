{ config, pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableSSHSupport = true;
  };
}