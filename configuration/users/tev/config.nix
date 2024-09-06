{ config, pkgs, username, host-name, addresses, inputs, ... }:
let pack = [
  (pkgs.callPackage ./config/dot-config.pkg.nix {})
  # (pkgs.callPackage ./config/plasma-config.pkg.nix { inherit host-name addresses inputs; })
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
    home.file.".xbindkeysrc" = {
      source = ./config/.xbindkeysrc;
    };
  };
}
