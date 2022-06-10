{ config, pkgs, ... }:
let
  username = "tev";
in
{
  imports =
  [
    ((import ./templates/persist.nix) { username = "${username}"; })
    ./tev/packages.nix
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
    xdg = {
      configFile = {
        "." = {
          recursive = true;
          source = (pkgs.callPackage ./tev/plasma-config/rc.nix {});
        };
      };
    };
    gtk = {
      enable = true;

    };
  };
}
