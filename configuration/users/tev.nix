{ config, pkgs, ... }:
let
  username = "tev";
in
{
  imports =
  [
    ((import ./templates/persist.nix) { username = "${username}"; })
    ((import ./tev/config.nix) { username = "${username}"; })
    ((import ./tev/packages.nix) { username = "${username}"; })
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';
    shell = pkgs.fish;
  };

  home-manager.users.${username} = {
    home = {
      stateVersion = "21.11";
    };
    gtk = {
      enable = true;

    };
  };
}
