{ pkgs, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
    podman.dockerSocket.enable = true;
    podman.defaultNetwork.dnsname.enable = true;
  };
}