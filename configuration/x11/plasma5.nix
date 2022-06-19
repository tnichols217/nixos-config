{ config, pkgs, chili, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.enableHidpi = true;
  services.xserver.displayManager.sddm.theme = "${chili}";
  services.xserver.desktopManager.plasma5.enable = true;
}