{ pkgs, attrs, config, addresses, ports, addressNumbers, ... }:
let
  hostAddress = host: "10.1.${addressNumbers.${host}}.2";
in
{
  # users.users.nginx.extraGroups = ["wwwrun"];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
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
        locations."/".proxyPass = "http://${hostAddress "jellyfin"}:${toString ports.jellyfin}";
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
    };
  };
}