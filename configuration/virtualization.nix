{ pkgs, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    programs.virt-manager.enable = true;
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
    virtualisation.anbox.enable = true;
    podman.enable = true;
    podman.dockerSocket.enable = true;
    podman.dockerCompat = true;
  };
}