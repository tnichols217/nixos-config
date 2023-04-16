{ config, pkgs, attrs, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.enableHidpi = true;
  services.xserver.displayManager.sddm.theme = "${attrs.chili}";
  services.xserver.desktopManager.plasma5.enable = true;
  programs.xwayland.enable = true;
}