{ pkgs, ports, version, mkMerge, lib, addressNumbers, ... } :
let
  localAddress = host: "10.0.0.${addressNumbers.${host}}";
  hostAddress = host: "10.0.1.${addressNumbers.${host}}";
  group = "servarr";
  gid = 1000;
  confCont = { name }: {
    interfaces."ve-${name}".ipv4.addresses = [{
      address = hostAddress name;
      prefixLength = 24;
    }];
    containers.${name} = {
      autoStart = true;
      ephemeral = true;
      privateNetwork = true;
      hostBridge = "brwg";
      localAddress = "${localAddress name}";
      # hostAddress = "${hostAddress name}";
      # interfaces = [ "wg0" ];
      forwardPorts = [
        {
          containerPort = ports.${name};
          hostPort = ports.${name};
          protocol = "tcp";
        }
      ];
      config = {
        system.stateVersion = version;
        networking.firewall.enable = false;
        networking.useHostResolvConf = lib.mkForce false;
        users.groups."${group}" = {
          inherit gid;
        };
        services = {
          resolved.enable = true;
          ${name} = {
            enable = true;
          };
        };
      };
    };
  };
  mapFunc = name: {
    containers.${name} = {
      bindMounts = {
        "/var/lib/${name}" = {
          hostPath = "/var/lib/${name}";
          isReadOnly = false;
        };
      };
    };
  };
  mounts = names: lib.mkMerge (pkgs.lib.lists.map mapFunc names);
  confContGr = { name }: lib.mkMerge [(confCont { inherit name; }) (mounts [ name ]) {
    containers.${name} = {
      config = {
        services = {
          "${name}" = {
            group = "${group}";
          };
        };
      };
    };
  }];
  confContArr = { name, capName }: lib.mkMerge [(confContGr { inherit name; } ) {
    containers.${name} = {
      config = {
        services = {
          "${name}" = {
            dataDir = "/var/lib/${name}/.config/${capName}";
          };
        };
      };
    };
  }];
  confContJelly = { name }: lib.mkMerge [(confContGr { inherit name; } ) (mounts [
    "lidarr/data"
    "radarr/data"
    "sonarr/data"
    "readarr/data"
  ])];
  confContProw = { name }: lib.mkMerge [(confCont { inherit name; } ) {
    containers.${name} = {
      bindMounts = {
        "/var/lib/private/${name}" = {
          hostPath = "/var/lib/private/${name}";
          isReadOnly = false;
        };
      };
      config = {
        virtualisation.oci-containers.containers = {
          flaresolverr = {
            ports = [
              "8191:8191"
            ];
            imageFile = pkgs.dockerTools.pullImage{
              imageName = "flaresolverr/flaresolverr";
              finalImageTag = "v3.3.16";
              imageDigest = "sha256:35feb16defbc4a0012143ec14e7eabdf361a1a1f31075db49e85ccd8cc1ee485";
              sha256 = "000rsk86w398v9gdf1r2vy1b9190kimqmlnifsnj16nxk0bma1f4";
            };
            image = "flaresolverr/flaresolverr";
          };
        };
      };
    };
  }];
in
lib.mkMerge [
  {
    users.groups."${group}" = {
      inherit gid;
    };
  }
  confContArr {
    name = "lidarr";
    capName = "Lidarr";
  }
  confContArr {
    name = "radarr";
    capName = "Radarr";
  }
  confContArr {
    name = "sonarr";
    capName = "Sonarr";
  }
  confContArr {
    name = "readarr";
    capName = "Readarr";
  }
  confContGr {
    name = "transmission";
  }
  confContJelly {
    name = "jellyfin";
  }
  confContProw {
    name = "prowlarr";
  }
]

  # services = {
  #   lidarr = {
  #     enable = true;
  #     group = "${group}";
  #     dataDir = "/var/lib/lidarr/.config/Lidarr";
  #   };
  #   radarr = {
  #     enable = true;
  #     group = "${group}";
  #     dataDir = "/var/lib/radarr/.config/Radarr";
  #   };
  #   sonarr = {
  #     enable = true;
  #     group = "${group}";
  #     dataDir = "/var/lib/sonarr/.config/Sonarr";
  #   };
  #   readarr = {
  #     enable = true;
  #     group = "${group}";
  #     dataDir = "/var/lib/readarr/.config/Readarr";
  #   };
  #   transmission = { # port 9091
  #     enable = true;
  #     group = "${group}";
  #   };
  #   prowlarr = {
  #     enable = true;
  #   };
  #   jellyfin = {
  #     enable = true;
  #     group = "${group}";
  #   };
  # };

  # virtualisation.oci-containers.containers = {
  #   flaresolverr = {
  #     ports = [
  #       "8191:8191"
  #     ];
  #     imageFile = pkgs.dockerTools.pullImage{
  #       imageName = "flaresolverr/flaresolverr";
  #       finalImageTag = "v3.3.16";
  #       imageDigest = "sha256:35feb16defbc4a0012143ec14e7eabdf361a1a1f31075db49e85ccd8cc1ee485";
  #       sha256 = "000rsk86w398v9gdf1r2vy1b9190kimqmlnifsnj16nxk0bma1f4";
  #     };
  #     image = "flaresolverr/flaresolverr";
  #   };
  # };

  systemd.tmpfiles.rules = [
    "Z /var/lib/lidarr 0775 root ${group}"
    "Z /var/lib/radarr 0775 root ${group}"
    "Z /var/lib/sonarr 0775 root ${group}"
    "Z /var/lib/readarr 0775 root ${group}"
    "Z /var/lib/jellyfin 0775 root ${group}"
    "Z /var/lib/transmission 0775 root ${group}"
  ];
}