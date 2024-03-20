{ pkgs, ports, version, mkMerge, lib, addressNumbers, ... } :
let
  localAddress = host: "10.1.${addressNumbers.${host}}.3";
  localExtraAddress = host: "10.1.${addressNumbers.${host}}.2";
  hostAddress = host: "10.1.${addressNumbers.${host}}.1";
  group = "servarr";
  gid = 1000;
  confCont = { name }: {
    # networking.interfaces."vb-${name}".ipv4.addresses = [{
    #   address = hostAddress name;
    #   prefixLength = 24;
    # }];
    containers.${name} = {
      autoStart = true;
      ephemeral = true;
      privateNetwork = false;
      # hostBridge = "brwg";
      # localAddress = "${localAddress name}";
      # hostAddress = "${hostAddress name}";
      # interfaces = [ "wg0" ];
      # forwardPorts = [
      #   {
      #     containerPort = ports.${name};
      #     hostPort = ports.${name};
      #     protocol = "tcp";
      #   }
      # ];
      # extraVeths = {
      #   "ve2-${name}" = {
      #     localAddress = "${localExtraAddress name}";
      #     hostAddress = "${hostAddress name}";
      #     forwardPorts = [
      #       {
      #         containerPort = ports.${name};
      #         hostPort = ports.${name};
      #         protocol = "tcp";
      #       }
      #     ];
      #   };
      # };
      config = {
        system.stateVersion = version;
        networking = {
          firewall.enable = false;
          # useHostResolvConf = lib.mkForce false;
          # defaultGateway = "10.0.2.1";
        };
        users.groups."${group}" = {
          inherit gid;
        };
        services = {
          # resolved.enable = true;
          ${name} = {
            enable = true;
          };
        };
      };
    };
  };
  mapFunc = name: {
    bindMounts = {
      "/var/lib/${name}" = {
        hostPath = "/var/lib/${name}";
        isReadOnly = false;
      };
    };
  };
  mounts = names: lib.mkMerge (pkgs.lib.lists.map mapFunc names);
  confContGr = { name }: lib.mkMerge [(confCont { inherit name; }) {
    containers.${name} = lib.mkMerge [{
      config = {
        services = {
          "${name}" = {
            group = "${group}";
          };
        };
      };
    } (mounts [ name ])];
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
  confContQbit = { name, capName }: lib.mkMerge [(confContGr { inherit name; } ) {
    containers.${name} = {
      config = {
        services = {
          "${name}" = {
            profileDir = "/var/lib/${name}";
            openFirewall = true;
            webuiPort = ports.qbitfe;
            torrentingPort = ports.qbittorrent;
            serverConfig = {
              BitTorrent = {
                Session = {
                  AddExtensionToIncompleteFiles = true;
                  Preallocation = true;
                  QueueingSystemEnabled = false;
                };
              };
              Core = {
                AutoDeleteAddedTorrentFile = "Never";
              };
              LegalNotice = {
                Accepted = true;
              };
              Network = {
                Proxy = {
                  AuthEnabled = false;
                  HostnameLookupEnabled = true;
                  IP = "10.64.0.1";
                  Password = "";
                  Port = "@Variant(\\0\\0\\0\\x85\\x4\\x38)";
                  Profiles = {
                    Misc = true;
                    RSS = true;
                  };
                  Type = "SOCKS5";
                  Username = "";
                };
              };
              Preferences = {
                WebUI = {
                  Username = "user";
                  Password_PBKDR2 = "@ByteArray(e88apKuE5EKe2cJXamorDg==:r96TVu5Ow7h376EbTOjgDUHiSJA3tKpyLmiRG8LwN89RaUi9WJkblqutLW1ogT6hWzEKgh4tFdXVJL7e2/Noyw==)";
                  ReverseProxySupportEnabled = true;
                };
                General.Locale = "en";
                MailNotification.req_auth = true;
              };
            };
          };
        };
      };
    };
  }];
  confContJelly = { name }: lib.mkMerge [(confContGr { inherit name; } ) (
    {
      containers.${name} = mounts [
        "lidarr/data"
        "radarr/data"
        "sonarr/data"
        "readarr/data"
      ];
    }
  )];
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
  confContTran = { name }: lib.mkMerge [(confContGr { inherit name; } ) {
    containers.${name} = {
      privateNetwork = lib.mkForce true;
      # localAddress = "${localAddress name}";
      extraVeths = {
        "wg0" = {
          # localAddress = "${localExtraAddress name}";
          # hostAddress = "${hostAddress name}";
          # forwardPorts = [
          #   {
          #     containerPort = ports.${name};
          #     hostPort = ports.${name};
          #     protocol = "tcp";
          #   }
          # ];
        };
      };
      hostBridge = lib.mkForce null;
      # interfaces = [ "wg0" ];
    };
  }];
in
lib.mkMerge [
  {
    users.groups."${group}" = {
      inherit gid;
    };
    systemd.tmpfiles.rules = [
      "Z /var/lib/lidarr 0775 root ${group}"
      "Z /var/lib/radarr 0775 root ${group}"
      "Z /var/lib/sonarr 0775 root ${group}"
      "Z /var/lib/readarr 0775 root ${group}"
      "Z /var/lib/jellyfin 0775 root ${group}"
      "Z /var/lib/transmission 0775 root ${group}"
    ];
  }
  (confContArr {
    name = "lidarr";
    capName = "Lidarr";
  })
  (confContArr {
    name = "radarr";
    capName = "Radarr";
  })
  (confContArr {
    name = "sonarr";
    capName = "Sonarr";
  })
  (confContArr {
    name = "readarr";
    capName = "Readarr";
  })
  # (confContTran {
  #   name = "transmission";
  # })
  (confContQbit {
    name = "qbittorrent"
  })
  (confContJelly {
    name = "jellyfin";
  })
  (confContProw {
    name = "prowlarr";
  })
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