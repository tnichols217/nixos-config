{ config, pkgs, attrs, ... }:
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.enableHidpi = true;
  services.displayManager.sddm.theme = "${attrs.chili}";
}