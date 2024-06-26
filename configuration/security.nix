{ config, pkgs, lib, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  security.pam.u2f.enable = true;

  security.pam.services = {
    hyprland = {
      u2fAuth = true;
      unixAuth = true;
    };
    sddm.u2fAuth = true;
    greetd.u2fAuth = true;
    sddm-greeter.u2fAuth = true;
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    kde.u2fAuth = true;
    xscreensaver.u2fAuth = true;
  };
}