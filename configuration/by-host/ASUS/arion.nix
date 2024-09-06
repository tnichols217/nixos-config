{ pkgs, inputs, config, ... }:
{
  nixpkgs.overlays = [
    # inputs.minecraft-arion.overlays.x86_64-linux
  ];

  environment.variables = {
    DOCKER_HOST = "unix:///run/podman/podman.sock";
  };

  environment.systemPackages = [
    pkgs.arion
  ];

  virtualisation.arion = {
    backend = "podman-socket";
    projects.minecraft.settings = {
      imports = [ inputs.minecraft-arion.arion-module ];
    };
  };
}