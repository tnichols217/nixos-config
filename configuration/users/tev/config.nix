{ username }:
{ config, pkgs, ... }:
let pack = [
  (pkgs.callPackage ./config/dot-config.pkg.nix {})
  (pkgs.callPackage ./config/plasma-config.pkg.nix {})
];
in
{
  home-manager.users.${username} = {
    xdg = {
      configFile = {
        "." = {
          recursive = true;
          source = (pkgs.callPackage ./config/combine.pkg.nix { inherit pack; });
        };
      };
    };
  };
}
