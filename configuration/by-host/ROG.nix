{ pkgs, addresses, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-openconnect
    ];
  };

  services.asusd.enable = true;

  # TODO move pipewire config to config files instead

  # services.pipewire = {
  #   extraConfig = {
  #     pipewire = {
  #       "10-network-sink" = {
  #         "context.modules" = [
  #           {
  #             name = "libpipewire-module-pulse-tunnel";
  #             args = {
  #               "tunnel.mode" = "sink";
  #               "pulse.server.address" = "tcp:tln32asus.student.cwru.edu";
  #             };
  #           }
  #           {
  #             name = "libpipewire-module-zeroconf-discover";
  #             args = {};
  #           }
  #         ];
  #       };
  #     };

  #     pipewire-pulse = {
  #       "10-network-sink" = {
  #         "pulse.properties" = {
  #           "server.address" = [
  #             "unix:native"
  #             "tcp:4713"
  #           ];
  #         };
  #       };
  #     };
  #   };
  # };

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        systems = [
          "x86_64-linux"
          "i686-linux"
          "aarch64-linux"
        ];
        supportedFeatures = [
          "kvm"
        ];
        sshUser = "tev";
        sshKey = "/home/tev/.ssh/ed25519";
        hostName = "${addresses.default}:2200";
      }
    ];
    settings = {
      "max-jobs" = 8;
    };
  };
}