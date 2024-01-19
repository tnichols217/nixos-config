{ pkgs, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-openconnect
    ];
  };

  services.xserver.desktopManager.plasma5.useQtScaling = true;

  # TODO move pipewire config to config files instead

  services.pipewire = {
    extraConfig = {
      pipewire = {
        "10-network-sink" = {
          "context.modules" = [
            {
              name = "libpipewire-module-pulse-tunnel";
              args = {
                "tunnel.mode" = "sink";
                "pulse.server.address" = "tcp:tln32asus.student.cwru.edu";
              };
            }
            {
              name = "libpipewire-module-zeroconf-discover";
              args = {};
            }
          ];
        };
      };

      pipewire-pulse = {
        "10-network-sink" = {
          "pulse.properties" = {
            "server.address" = [
              "unix:native"
              "tcp:4713"
            ];
          };
        };
      };
    };
  };

  nix.distributedBuilds = true;

  nix.settings = {
    "max-jobs" = 8;
    "builders" = 
      ''ssh://tev@tln32asus.student.cwru.edu?ssh-key=/home/tev/.ssh/ed25519 x86_64-linux,i686-linux - 8 5 kvm - c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUExd1hDelZSTkt5VHlLUENVYUZBV0xwaFRRdmt1citpUDZMWEszYWRWY0sgcm9vdEBBU1VTCg=='';
  };
}