args@{ pkgs, btf, host-name, ... }:
let
  username = "root";
in
{
  imports =
  [
    ((import ./templates/default_home_manager.nix) (args // { inherit pkgs btf username host-name; }))
  ];
}
