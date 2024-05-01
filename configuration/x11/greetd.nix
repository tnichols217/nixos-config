{ config, pkgs, attrs, ... }:
{
  services.greetd = {
    enable = true;
    default_session = {
      command = "Hyprland";
    };
    package = pkgs.greetd.tuigreet;
    restart = true;
  };
}