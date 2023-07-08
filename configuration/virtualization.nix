{ pkgs, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    virtualisation.podman.enable = true;
    virtualisation.podman.dockerSocket.enable = true;
    virtualisation.podman.defaultNetwork.dnsname.enable = true;
  };
}