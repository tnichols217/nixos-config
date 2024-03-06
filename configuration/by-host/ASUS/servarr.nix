{ pkgs, ports, version, mkMerge, lib, ... } :
let
  group = "servarr";
  confCont = { name }: {
    autoStart = true;
    ephemeral = true;
    privateNetwork = true;
    hostBridge = "brwg";
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
      users.groups."${group}" = {};
      services = {
        ${name} = {
          enable = true;
        };
      };
    };
  };
  confContGr = { name }: lib.mkMerge [(confCont { inherit name; })  {
    bindMounts = {
      "/var/lib/${name}" = {
        hostPath = "/var/lib/${name}";
        isReadOnly = false;
      };
    };
    config = {
      services = {
        "${name}" = {
          group = "${group}";
        };
      };
    };
  }];
  confContArr = { name, capName }: lib.mkMerge [(confContGr { inherit name; } ) {
    config = {
      services = {
        "${name}" = {
          dataDir = "/var/lib/${name}/.config/${capName}";
        };
      };
    };
  }];
  confContProw = { name }: lib.mkMerge [(confContGr { inherit name; } ) {
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
  }];
in
{

  users.groups."${group}" = {};

  # containers = {
  #   lidarr = confContArr {
  #     name = "lidarr";
  #     capName = "Lidarr";
  #   };
  #   radarr = confContArr {
  #     name = "radarr";
  #     capName = "Radarr";
  #   };
  #   sonarr = confContArr {
  #     name = "sonarr";
  #     capName = "Sonarr";
  #   };
  #   readarr = confContArr {
  #     name = "readarr";
  #     capName = "Readarr";
  #   };
  #   transmission = confContGr {
  #     name = "transmission";
  #   };
  #   jellyfin = confContGr {
  #     name = "jellyfin";
  #   };
  #   prowlarr = confCont {
  #     name = "prowlarr";
  #   };
  # };

  services = {
    lidarr = {
      enable = true;
      group = "${group}";
      dataDir = "/var/lib/lidarr/.config/Lidarr";
    };
    radarr = {
      enable = true;
      group = "${group}";
      dataDir = "/var/lib/radarr/.config/Radarr";
    };
    sonarr = {
      enable = true;
      group = "${group}";
      dataDir = "/var/lib/sonarr/.config/Sonarr";
    };
    readarr = {
      enable = true;
      group = "${group}";
      dataDir = "/var/lib/readarr/.config/Readarr";
    };
    transmission = { # port 9091
      enable = true;
      group = "${group}";
    };
    prowlarr = {
      enable = true;
    };
    jellyfin = {
      enable = true;
      group = "${group}";
    };
  };

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

  systemd.tmpfiles.rules = [
    "Z /var/lib/lidarr 0775 lidarr ${group}"
    "Z /var/lib/radarr 0775 radarr ${group}"
    "Z /var/lib/sonarr 0775 sonarr ${group}"
    "Z /var/lib/readarr 0775 readarr ${group}"
    "Z /var/lib/jellyfin 0775 jellyfin ${group}"
    "Z /var/lib/transmission 0775 transmission ${group}"
  ];
}