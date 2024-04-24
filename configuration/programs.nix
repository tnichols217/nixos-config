{ config, pkgs, ... }:
{
  services.flatpak.enable = true;
  programs.gamemode.enable = true;
  # nixpkgs.overlays = [
  #   (
  #     self: super: {
  #           kitty = import ./kitty/kitty.pkg.nix { pkgs = super; inherit self; inherit attrs; };
  #         }
  #   )
  # ];
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.kde.okular.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "text/plain" = "codium.desktop";
      "image/svg+xml" = "inkscape.desktop";
      "video/mp4" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
    };
  };
}