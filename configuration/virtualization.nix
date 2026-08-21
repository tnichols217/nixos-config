{ pkgs, host-name, ... }:
{
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    waydroid.enable = true;
    podman.enable = true;
    podman.dockerSocket.enable = host-name == "ASUS";
    podman.dockerCompat = true;
  };
  environment.systemPackages = [
    pkgs.swtpm
  ];
  boot.binfmt.emulatedSystems = [
    "wasm32-wasip1"
    "wasm64-wasip1"
    "x86_64-windows"
    "aarch64-linux"
    "riscv32-linux"
    "riscv64-linux"
  ];
  programs.nix-ld.enable = true;
}
