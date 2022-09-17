{ config, pkgs, username, ... }:
{
  users.users.${username} = {
    extraGroups = [ "wheel" "libvirtd" "networkmanager" "docker" ];
  };
}