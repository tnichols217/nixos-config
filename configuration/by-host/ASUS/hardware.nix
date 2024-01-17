{ pkgs, attrs, config, ... }:
{
  imports = [
    ./hardware/fs.nix
    ./hardware/nvidia.nix
  ];
}