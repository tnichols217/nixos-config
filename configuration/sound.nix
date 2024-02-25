{ config, pkgs, ... }:
{
  sound.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
  programs.noisetorch.enable = true;
}