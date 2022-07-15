{ pkgs, ... }:
{
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
      # pipewire-pulse = {
      #   "context.exec" = [
      #     { path = "pactl"; args = "load-module module-tunnel-sink server=tcp:192.168.100.250:4713"; }
      #   ];
      # };
      pipewire = {
        "context.modules" = [
          {
            name = "libpipewire-module-pulse-tunnel";
            args = {
              tunnel.mode = "sink";
              pulse.server.address = "tcp:192.168.1.250";
            };
          }
        ];
      };
    };
  };
}