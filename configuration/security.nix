{ config, pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  security.pam.u2f.enable = true;

  security.pam.services = {
    sddm.u2fAuth = true;
    sddm-greeter.u2fAuth = true;
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    kde.u2fAuth = true;
    xscreensaver.u2fAuth = true;
  };
}