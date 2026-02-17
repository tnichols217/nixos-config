{ config, pkgs, lib, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time  --user-menu --cmd start-hyprland";
        user = "greeter";
      };
      terminal = {
        vt = lib.mkForce 3;
      };
    };
    restart = true;
  };
}