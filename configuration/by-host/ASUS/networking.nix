{ pkgs, attrs, config, ... }:
{
  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    networks = {
      "NICHOLS 5Ghz" = {
        psk = "0194815801";
      };
    };
  };
}