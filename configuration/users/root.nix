args@{ pkgs, host-name, version, ... }:
let
  username = "root";
in
{
  imports =
  [
    ((import ./templates/default_home_manager.nix) (args // { inherit pkgs username host-name version; }))
  ];
}
