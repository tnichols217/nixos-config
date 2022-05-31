{ config, pkgs, ... }:
{
  users.users.tev = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';
  };

  home-manager.users.tev = {
    home = {
      stateVersion = "21.11";
      packages = with pkgs; [
        vscodium
        obsidian
        barrier
        firefox
        gnupg
      ];
    };
    programs = {
      git = {
        enable = "true";
        userName = "tnichols217";
        userEmail = "62992267+tnichols217@users.noreply.github.com";
      };
    }
  };
}