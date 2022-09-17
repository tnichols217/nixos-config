args@{ pkgs, btf, ... }:
let
  username = "root";
in
{
  imports =
  [
    ((import ./templates/default_home_manager.nix) (args // { inherit pkgs btf username; }))
  ];
}
