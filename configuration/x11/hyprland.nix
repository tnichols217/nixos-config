{ config, pkgs, attrs, ... }:
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.enableHidpi = true;
  services.displayManager.sddm.theme = "${attrs.chili}";
  programs.xwayland.enable = true;
  programs.hyprland.enable = true;
  systemd.tmpfiles.rules = [
    "d! /etc/hypr 0777 root users"
  ];
}