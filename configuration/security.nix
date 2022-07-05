{ config, pkgs, ... }:
{
  security.doas.enable = true;
  security.sudo.enable = false;
}