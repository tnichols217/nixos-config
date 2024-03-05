{ pkgs, attrs, config, addresses, ports, ... }:
{
  # users.users.nginx.extraGroups = ["wwwrun"];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
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
        locations."/".proxyPass = "http://localhost:${ports.lidarr}";
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
        locations."/".proxyPass = "http://localhost:${ports.radarr}";
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
        locations."/".proxyPass = "http://localhost:${ports.sonarr}";
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
        locations."/".proxyPass = "http://localhost:${ports.readarr}";
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
        locations."/".proxyPass = "http://localhost:${ports.prowlarr}";
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
        locations."/".proxyPass = "http://localhost:${ports.jellyfin}";
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