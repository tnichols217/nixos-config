args@{ config, pkgs, version, host-name, ... }:
let
  username = "soda";
in
{
  imports =
  [
    ((import ./templates/persist.nix) (args // { inherit username; }))
    ((import ./templates/normal_sudo.nix) (args // { inherit username; }))
    ((import ./templates/default_home_manager.nix) (args // { inherit pkgs username host-name version; }))
  ];

  users.users.${username}.hashedPassword = ''$y$j9T$wyokdDYUPZ5/uls7x2XtL1$tjSk0rJvgMAjVz8q2e4t1wT7t9BgWWuf1dPPg0nhjd4'';

  home-manager.users.${username} = {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita-dark";
      };
    };
  };
}
