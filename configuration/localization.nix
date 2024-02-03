{ config, pkgs, ... }:
{
  # time.timeZone = "Asia/Kuala_Lumpur";
  time.timeZone = "America/New_York";
  i18n = {
    defaultLocale = "en_SG.UTF-8";
    supportedLocales = [
      "all"
    ];
  };
  services.geoclue2.enable = true;
  services.localtimed.enable = true;
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  services.xserver.xkb.layout = "us";
}