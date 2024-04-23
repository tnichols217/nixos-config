{ config, pkgs, ... }:
{
  services.flatpak.enable = true;
  programs.gamemode.enable = true;
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "okular.desktop";
      "image/png" = "gwenview.desktop";
      "text/plain" = "codium.desktop";
      "image/svg+xml" = "inkscape.desktop";
      "video/mp4" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
    };
  };
}