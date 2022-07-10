{ host-name, ... }:
{
  imports = [
    "./by-host/${host-name}.nix"
  ]
}