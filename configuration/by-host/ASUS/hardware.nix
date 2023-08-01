{ pkgs, attrs, config, ... }:
{
  imposts = [
    ./hardware/fs.nix
    ./hardware/nvidia.nix
  ];
}