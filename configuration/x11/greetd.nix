{ config, pkgs, attrs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
      };
    };
    package = pkgs.greetd.tuigreet;
    restart = true;
  };
}