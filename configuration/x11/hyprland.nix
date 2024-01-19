{ config, pkgs, attrs, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.enableHidpi = true;
  services.xserver.displayManager.sddm.theme = "${attrs.chili}";
  programs.xwayland.enable = true;
  programs.hyprland.enable = true;
}