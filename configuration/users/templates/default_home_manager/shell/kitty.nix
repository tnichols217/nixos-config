{ pkgs, attrs, username, host-name, version, lib, nix-index-database, ... }:
{
  nixpkgs.overlays = [
    (
      self: super: {
            kitty = import ./kitty/kitty.pkg.nix { pkgs = super; inherit self; inherit attrs; };
          }
    )
  ];

  home-manager.users.${username} = {
    programs = {
      kitty = {
        enable = true;
        settings = {
          background_opacity = "0.5";
          background_blur = 5;
        };
        keybindings = {
          "ctrl+shift+t" = "new_tab_with_cwd !neighbor";
          "ctrl+shift+alt+t" = "new_tab !neighbor";
        };
      };
    };
  };
}
