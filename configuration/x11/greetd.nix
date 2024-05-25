{ config, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time  --user-menu --cmd Hyprland";
        user = "greeter";
      };
      terminal = {
        vt = 3;
      };
    };
    package = pkgs.greetd.tuigreet;
    restart = true;
  };
}