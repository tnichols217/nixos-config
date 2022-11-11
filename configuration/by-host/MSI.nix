{ pkgs, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-openconnect
    ];
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
    '')
  ];

  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.pipewire = {
    config.pipewire-pulse = {
      "pulse.properties" = {
        "server.address" = [
          "unix:native"
          "tcp:4713"
        ];
      };
    };
  };

  nix.distributedBuilds = true;

  nix.settings = {
    "max-jobs" = 8;
    "builders" = 
      ''ssh://tev@192.168.100.200?ssh-key=/home/tev/.ssh/ed25519 x86_64-linux,i686-linux - 8 5 kvm - c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUExd1hDelZSTkt5VHlLUENVYUZBV0xwaFRRdmt1citpUDZMWEszYWRWY0sgcm9vdEBBU1VTCg=='';
    # substituters = [
    #   "http://192.168.100.200:5000"
    # ];
  };
}