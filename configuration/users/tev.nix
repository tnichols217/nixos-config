{ config, pkgs, ... }:
let
  username = "tev";
in
{
    imports =
    [
      ((import ./user.nix) { username = "${username}" })
    ];
}
