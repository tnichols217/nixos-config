{ config, pkgs, username, host-name, attrs, ... }:
let pack = [
  (pkgs.callPackage ./config/dot-config.pkg.nix {})
  (pkgs.callPackage ./config/plasma-config.pkg.nix { inherit host-name attrs; })
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
