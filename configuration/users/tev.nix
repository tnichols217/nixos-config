args@{ config, pkgs, btf, arch-theme, papirus, vscodeExtensions, version, ... }:
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

  users.users.${username}.hashedPassword = ''$6$jFmvFtj14aQAG7tk$FEl8XyZCoNEnxqTS1RFS821pmt/NynpTizF6JrOS90kO/qUKR1EeVjBMvIl9RywM.cTKhn8kNXqVzt8XYkY8T.'';

  home-manager.users.${username} = {
    home = {
      stateVersion = version;
    };
    gtk = {
      enable = true;
    };
  };
}
