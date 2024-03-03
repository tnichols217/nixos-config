{ pkgs, attrs, config, addresses, ... }:
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
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 5000;
            ssl = true;
          }
        ];
      };
      "nextcloud" = {
        locations."/".proxyPass = "http://localhost:80";
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 443;
            ssl = true;
          }
        ];
      };
      "lidarr" = {
        locations."/".proxyPass = "http://localhost:8686";
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 8687;
            ssl = true;
          }
        ];
      };
      "radarr" = {
        locations."/".proxyPass = "http://localhost:7878";
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 7879;
            ssl = true;
          }
        ];
      };
      "sonarr" = {
        locations."/".proxyPass = "http://localhost:8989";
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 8990;
            ssl = true;
          }
        ];
      };
      "readarr" = {
        locations."/".proxyPass = "http://localhost:8787";
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 8788;
            ssl = true;
          }
        ];
      };
      "prowlarr" = {
        locations."/".proxyPass = "http://localhost:9696";
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 9697;
            ssl = true;
          }
        ];
      };
      "jellyfin" = {
        locations."/".proxyPass = "http://localhost:8096";
        useACMEHost = "${addresses.default}";
        serverName = "${addresses.default}";
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 8090;
            ssl = true;
          }
        ];
      };
    };
  };
}