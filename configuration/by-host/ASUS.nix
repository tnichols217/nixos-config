{ pkgs, ... }:
{
  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    networks = {
      "NICHOLS 5Ghz" = {
        psk = "0194815801";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      webroot = "/var/lib/acme/acme-challenge";
      email = "62992267+tnichols217@users.noreply.github.com";
    };
    certs = {
      "heyo.ydns.eu" = {};
      "pigsgo.mooo.com" = {};
    };
  };

  fileSystems = {
    # server drive
    "/storage" = {
      device = "/dev/disk/by-label/WEBSTORAGE";
      fsType = "ext4";
    };
  };

  services.httpd = {
    enable = true;
    adminAddr = "Pathway2PBC@gmail.com";
    group = "acme";
    virtualHosts = let 
      defHost = host: {
        addSSL = true;
        documentRoot = "/storage/church/Public";
        useACMEHost = "${host
        }";
      };
    in {
      "heyo.ydns.eu" = defHost "heyo.ydns.eu";
      "pigsgo.mooo.com" = defHost "pigsgo.mooo.com";
    };
  };

  services.cron = {
    enable = true;
    systemCronJobs = [ ''0,5,10,15,20,25,30,35,40,45,50,55 * * * * root sh /storage/church/config/update.sh'' ];
  };

  services.pipewire = {
    config = {
      pipewire = {
        "context.modules" = [
          {
            name = "libpipewire-module-rt";
            args = {
              "nice.level" = -11;
            };
            flags = [ "ifexists" "nofail" ];
          }
          { name = "libpipewire-module-protocol-native"; }
          { name = "libpipewire-module-profiler"; }
          { name = "libpipewire-module-metadata"; }
          { name = "libpipewire-module-spa-device-factory"; }
          { name = "libpipewire-module-spa-node-factory"; }
          { name = "libpipewire-module-client-node" ;}
          { name = "libpipewire-module-client-device"; }
          {
            name = "libpipewire-module-portal";
            flags = [ "ifexists" "nofail" ];
          }
          {
            name = "libpipewire-module-access";
            args = {};
          }
          { name = "libpipewire-module-adapter"; }
          { name = "libpipewire-module-link-factory"; }
          { name = "libpipewire-module-session-manager"; }
          {
            name = "libpipewire-module-pulse-tunnel";
            args = {
              "tunnel.mode" = "sink";
              "pulse.server.address" = "tcp:192.168.100.250";
            };
          }
          {
            name = "libpipewire-module-zeroconf-discover";
            args = {};
          }
        ];
      };
    };
  };
}