{ pkgs, ... }:
{
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    waydroid.enable = true;
    podman.enable = true;
    podman.dockerSocket.enable = true;
    podman.dockerCompat = true;
  };
  environment.systemPackages = [
    pkgs.swtpm
  ];
  boot.binfmt.emulatedSystems = [
    "wasm32-wasi"
    "wasm64-wasi"
    "x86_64-windows"
    "aarch64-linux"
  ];
  programs.nix-ld.enable = true;
}