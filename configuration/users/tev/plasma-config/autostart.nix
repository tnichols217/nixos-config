{ username }:
{ config, pkgs, ... }:
{
  imports = [
    ((import ./autostart/save-desktop.nix) { app = pkgs.flameshot; name = "org.flameshot.Flameshot.desktop"; username = username; })
  ];
}
