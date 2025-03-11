{ pkgs, inputs, config, ... }:
{
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