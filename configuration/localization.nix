{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kuala_Lumpur";
  i18n = {
    defaultLocale = "en_SG.UTF-8";
    supportedLocales = [
      "en_SG.UTF-8/UTF-8"
    ];
  };
  services.geoclue2.enable = true;
  services.localtimed.enable = true;
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  services.xserver.layout = "us";
}