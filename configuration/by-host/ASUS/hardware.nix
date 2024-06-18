{ pkgs, config, ... }:
{
  imports = [
    ./hardware/fs.nix
    ./hardware/nvidia.nix
  ];

  services.power-profiles-daemon.enable = true;
}