{ config, pkgs, username, ... }:
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
          source = (pkgs.callPackage ./metapkgs/combine.metapkg.nix { inherit pack; });
        };
      };
    };
  };
}
