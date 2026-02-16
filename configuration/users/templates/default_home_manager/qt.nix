{ pkgs, username, inputs, ... }:
{
  home-manager.users.${username} = {
    qt = let
      settings = {
        Appearance = {
          style = "adwaita-dark";
          icon_theme = "Papirus-Dark";
          standard_dialogs = "xdgdesktopportal";
        };
        Fonts = {
          fixed = "\"DejaVuSansM Nerd Font Mono,12\"";
          general = "\"DejaVu Sans,12\"";
        };
      };
    in {
      enable = true;
      platformTheme = {
        name = "adwaita";
      };
      style = {
        name = "adwaita-dark";
      };
    };
    qt5ctSettings = settings;
    qt6ctSettings = settings;
  };
}