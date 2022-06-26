{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kuala_Lumpur";
  i18n.defaultLocale = "en_SG.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  services.xserver.layout = "us";
}