{ pkgs, attrs, username, host-name, version, lib, nix-index-database, ... }:
{
  imports = [
    # ./default_home_manager/shell.nix
  ];

  home-manager.backupFileExtension = "backup";

  systemd.services."home-manager-${username}" = {
    after = [ "systemd-tmpfiles-setup.service" ];
    # before = [ "home-manager-${username}.service" ];
    # script = "echo home-manager-${username} force dep on tmpfiles";
    # description = "home-manager-${username} force dep on tmpfiles";
  };

  systemd.tmpfiles.rules = [
    "d /home/${username} 0700 ${username} users"
    "z /home/${username} 0700 ${username} users"
    # "f /home/${username}/.local/state/nix/profiles/tmp/manifest.json 0755 ${username} users"
    # "L /home/${username}/.local/state/nix/profiles/profile 0755 ${username} users - /home/${username}/.local/state/nix/profiles/tmp"
    # "L /home/${username}/.local/state/nix/profiles/home-manager 0755 ${username} users - /home/${username}/.local/state/nix/profiles/tmp"
    # "L /home/${username}/.nix-profile 0755 ${username} users - /home/${username}/.local/state/nix/profiles/profile"
    # "f /home/${username}/.nix-profile/manifest.json 0755 ${username} users"
  ];

  programs.command-not-found.enable = pkgs.lib.mkForce false;

  home-manager.users.${username} = {
    home = {
      stateVersion = version;
      forceNixProfiles = true;
    };
    services = {
      xsettingsd = {
        enable = true;
        settings = {
          "Gdk/UnscaledDPI" = if host-name == "ROG" then 147456 else 98304;
          "Gdk/WindowScalingFactor" = 1;
          "Gtk/EnableAnimations" = 1;
          "Gtk/DecorationLayout" = "icon:minimize,maximize,close";
          "Gtk/PrimaryButtonWarpsSlider" = 0;
          "Gtk/ToolbarStyle" = 3;
          "Gtk/MenuImages" = 1;
          "Gtk/ButtonImages" = 1;
          "Gtk/CursorThemeSize" = 24;
          "Gtk/CursorThemeName" = "breeze_cursors";
          "Net/IconThemeName" = "Papirus-Dark";
          "Gtk/FontName" = "Noto Sans,  10";
        };
      };
    };
  };
}
