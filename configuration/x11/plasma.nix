{ config, pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  programs.xwayland.enable = true;

  # environment.variables = {
  #   GDK_SCALE = "2";
  #   GDK_DPI_SCALE = "0.5";
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  #   QT_SCALE_FACTOR = "1.2";
  # };
}