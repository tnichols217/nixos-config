{ config, pkgs, attrs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
        user = "greeter";
      };
    };
    package = pkgs.greetd.tuigreet;
    restart = true;
  };
}