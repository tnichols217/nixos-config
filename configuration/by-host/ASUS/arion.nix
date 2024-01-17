{ pkgs, attrs, config, ... }:
{
  nixpkgs.overlays = [
    attrs.minecraft-arion.overlays.x86_64-linux
  ];

  environment.systemPackages = [
    pkgs.arion
  ];

  virtualisation.arion = {
    backend = "podman-socket";
    projects.minecraft.settings = {
      imports = [ attrs.minecraft-arion.arion-module ];
    };
  };
}