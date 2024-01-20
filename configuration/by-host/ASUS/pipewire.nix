{ pkgs, attrs, config, ... }:
{
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
  #               "pulse.server.address" = "tcp:tln32rog.student.cwru.edu";
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
}