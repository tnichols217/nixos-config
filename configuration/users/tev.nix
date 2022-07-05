args@{ config, pkgs, btf, arch-theme, papirus, vscodeExtensions, ... }:
let
  username = "tev";
in
{
  imports =
  [
    ((import ./templates/persist.nix) (args // { inherit username; }))
    ((import ./templates/normal_sudo.nix) (args // { inherit username; }))
    ((import ./tev/config.nix) (args // { inherit username; }))
    ((import ./tev/packages.nix) (args // { inherit username arch-theme papirus vscodeExtensions; }))
  ];

  users.users.${username}.hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';

  home-manager.users.${username} = {
    home = {
      stateVersion = system.stateVersion;
    };
    gtk = {
      enable = true;
    };
  };
}
