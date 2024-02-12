{ pkgs, ... }:
{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  
  virtualisation = {
    libvirtd.enable = true;
    programs.virt-manager.enable = true;
    anbox.enable = true;
    podman.enable = true;
    podman.dockerSocket.enable = true;
    podman.dockerCompat = true;
  };
}