{ pkgs, attrs, config, addresses, ports, addressNumbers, ... }:
let
  # hostAddress = host: "10.1.${addressNumbers.${host}}.1";
  hostAddress = host: "localhost";
in
{
  # users.users.nginx.extraGroups = ["wwwrun"];

  services = {
    authelia.instances = {
      pigs = {
        enable = true;
        settings = {
          default_2fa_method = "webauthn";
          server.port = ports.authelia;
  
          authentication_backend = {
            file = {
              path = "/var/lib/authelia-main/users_database.yml";
            };
          };
      
          access_control = {
            default_policy = "deny";
            rules = [
              {
                domain = [addresses.authelia];
                policy = "bypass";
              }
              {
                domain = ["*.${addresses.square}"];
                policy = "two_factor";
              }
            ];
          };
      
          session = {
            name = "authelia_session";
            expiration = "12h";
            inactivity = "45m";
            remember_me_duration = "1M";
            domain = "example.com";
            redis.host = "/run/redis-authelia-pigs/redis.sock";
          };
      
          regulation = {
            max_retries = 3;
            find_time = "5m";
            ban_time = "15m";
          };
      
          storage = {
            local = {
              path = "/var/lib/authelia/db.sqlite3";
            };
          };
        };
        secrets = {
          storageEncryptionKeyFile = "/var/lib/authelia/encrypt.pem";
          jwtSecretFile = "/var/lib/authelia/jwt.pem";
        };
      };
    };

    redis.servers.authelia-main = {
      enable = true;
      user = "authelia-pigs";   
      port = 0;
      unixSocket = "/run/redis-authelia-pigs/redis.sock";
      unixSocketPerm = 600;
    };

    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      streamConfig = ''
        server {
          listen 0.0.0.0:15565;
          include /var/lib/www-allow/allow.conf;
          proxy_timeout 20s;
          proxy_pass localhost:25565;
        }
      '';
      virtualHosts = {
        "acme" = {
          root = "/var/lib/acme/acme-challenge";
          listen = [
            {
              addr = "0.0.0.0";
              port = 80;
            }
          ];
        };
        "nix-serve" = {
          locations."/".proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
          useACMEHost = "${addresses.serve}";
          serverName = "${addresses.serve}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = ports.serve;
              ssl = true;
            }
          ];
        };
        "nextcloud" = {
          locations."/".proxyPass = "http://localhost:80";
          useACMEHost = "${addresses.nextcloud}";
          serverName = "${addresses.nextcloud}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = ports.nextcloud;
              ssl = true;
            }
          ];
        };
        "lidarr" = {
          locations."/".proxyPass = "http://${hostAddress "lidarr"}:${toString ports.lidarr}";
          useACMEHost = "${addresses.lidarr}";
          serverName = "${addresses.lidarr}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
        "radarr" = {
          locations."/".proxyPass = "http://${hostAddress "radarr"}:${toString ports.radarr}";
          useACMEHost = "${addresses.radarr}";
          serverName = "${addresses.radarr}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
        "sonarr" = {
          locations."/".proxyPass = "http://${hostAddress "sonarr"}:${toString ports.sonarr}";
          useACMEHost = "${addresses.sonarr}";
          serverName = "${addresses.sonarr}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
        "readarr" = {
          locations."/".proxyPass = "http://${hostAddress "readarr"}:${toString ports.readarr}";
          useACMEHost = "${addresses.readarr}";
          serverName = "${addresses.readarr}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
        "prowlarr" = {
          locations."/".proxyPass = "http://${hostAddress "prowlarr"}:${toString ports.prowlarr}";
          useACMEHost = "${addresses.prowlarr}";
          serverName = "${addresses.prowlarr}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
        "jellyfin" = {
          locations."/" = {
            proxyPass = "http://${hostAddress "jellyfin"}:${toString ports.jellyfin}";
            proxyWebsockets = true;
          };
          useACMEHost = "${addresses.jellyfin}";
          serverName = "${addresses.jellyfin}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
        "qbittorrent" = {
          locations."/" = {
            proxyPass = "http://${hostAddress "jellyfin"}:${toString ports.qbitfe}";
          };
          useACMEHost = "${addresses.qbittorrent}";
          serverName = "${addresses.qbittorrent}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
        "authelia" = {
          locations."/" = {
            proxyPass = "http://localhost:${toString ports.authelia}";
          };
          useACMEHost = "${addresses.authelia}";
          serverName = "${addresses.authelia}";
          forceSSL = true;
          listen = [
            {
              addr = "0.0.0.0";
              port = 443;
              ssl = true;
            }
          ];
        };
      };
    };
  };
}