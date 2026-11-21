{ hyprPkgs, ... }:
{
  programs.xwayland.enable = true;
  programs.hyprland = {
    enable = true;
    # The hypr2d plugin is built against this exact compositor revision;
    # the plugin ABI must match the running compositor. Pinned 0.56 source,
    # but built against the system nixpkgs (see hyprPkgs in flake.nix) so its
    # toolchain matches the runtime mesa drivers in /run/opengl-driver.
    package = hyprPkgs.hyprland;
  };
  systemd.tmpfiles.rules = [
    "d! /etc/hypr 0777 root users"
  ];
}
