{ pkgs, ... }:
{
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    tpm.enable = true;
    waydroid.enable = true;
    podman.enable = true;
    podman.dockerSocket.enable = true;
    podman.dockerCompat = true;
  };
}