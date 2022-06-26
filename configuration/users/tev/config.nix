{ config, pkgs, username, host-name, ... }:
let pack = [
  (pkgs.callPackage ./config/dot-config.pkg.nix {})
  (pkgs.callPackage ./config/plasma-config.pkg.nix { inherit host-name; })
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
