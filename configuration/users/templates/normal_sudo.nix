{ config, pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "networkmanager" "docker" "podman" "servarr" "input" ];
  };
}