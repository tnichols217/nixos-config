{ config, pkgs, inputs, ... }:
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.enableHidpi = true;
  services.displayManager.sddm.theme = "${pkgs.chili}";
}