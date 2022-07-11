{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kuala_Lumpur";
  i18n = {
    defaultLocale = "en_SG.UTF-8";
    inputMethod = {
      ibus.engines = with pkgs.ibus-engines; [ libpinyin typing-booster uniemoji ];
    };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  services.xserver.layout = "us";
}