{ pkgs, attrs, config, ... }:
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
        useACMEHost = "pigsgo.mooo.com";
        serverName = "pigsgo.mooo.com";
        forceSSL = true;
        # sslCertificateKey = "/var/lib/acme/pigsgo.mooo.com/key.pem";
        # sslCertificate = "/var/lib/acme/pigsgo.mooo.com/cert.pem";
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
        useACMEHost = "pigsgo.mooo.com";
        serverName = "pigsgo.mooo.com";
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