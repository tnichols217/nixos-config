{ config, pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableSSHSupport = true;
  };

  security.pam.services = {
    sddm.u2fAuth = true;
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}