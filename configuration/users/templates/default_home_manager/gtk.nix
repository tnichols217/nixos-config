{ pkgs, username, inputs, ... }:
{
  home-manager.users.${username} = {
    gtk ={
      enable = true;
      colorScheme = "dark";
      font = {
        package = pkgs.dejavu_fonts;
        name = "DejaVuSansM Nerd Font Mono";
      };
    };
  };
}