{ pkgs, attrs, config, ... }:
{
  # TODO move pipewire config to config files instead

  # services.pipewire = {
  #   config = {
  #     pipewire = {
  #       "context.modules" = [
  #         {
  #           name = "libpipewire-module-rt";
  #           args = {
  #             "nice.level" = -11;
  #           };
  #           flags = [ "ifexists" "nofail" ];
  #         }
  #         { name = "libpipewire-module-protocol-native"; }
  #         { name = "libpipewire-module-profiler"; }
  #         { name = "libpipewire-module-metadata"; }
  #         { name = "libpipewire-module-spa-device-factory"; }
  #         { name = "libpipewire-module-spa-node-factory"; }
  #         { name = "libpipewire-module-client-node" ;}
  #         { name = "libpipewire-module-client-device"; }
  #         {
  #           name = "libpipewire-module-portal";
  #           flags = [ "ifexists" "nofail" ];
  #         }
  #         {
  #           name = "libpipewire-module-access";
  #           args = {};
  #         }
  #         { name = "libpipewire-module-adapter"; }
  #         { name = "libpipewire-module-link-factory"; }
  #         { name = "libpipewire-module-session-manager"; }
  #         {
  #           name = "libpipewire-module-pulse-tunnel";
  #           args = {
  #             "tunnel.mode" = "sink";
  #             "pulse.server.address" = "tcp:192.168.100.250";
  #           };
  #         }
  #         {
  #           name = "libpipewire-module-zeroconf-discover";
  #           args = {};
  #         }
  #       ];
  #     };
  #   };
  # };
}