{ pkgs, config, ... }:
{
  imports = [
    ./hardware/fs.nix
    ./hardware/nvidia.nix
  ];
}