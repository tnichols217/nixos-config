{ config, pkgs, ... }:
{
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  programs.gamemode.enable = true;
  # nixpkgs.overlays = [
  #   (
  #     self: super: {
  #           kitty = import ./kitty/kitty.pkg.nix { pkgs = super; inherit self; inherit; };
  #         }
  #   )
  # ];
  xdg.mime = {
    enable = true;
    defaultApplications = let 
      brow = "firefox.desktop";
    in {
      "application/pdf" = "org.kde.okular.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "text/plain" = "codium.desktop";
      "image/svg+xml" = "inkscape.desktop";
      "video/mp4" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
      "text/html" = brow;
      "x-scheme-handler/http" = brow;
      "x-scheme-handler/https" = brow;
      "x-scheme-handler/about" = brow;
      "x-scheme-handler/unknown" = brow;
    };
  };
  environment.sessionVariables.DEFAULT_BROWSER = "firefox";
}