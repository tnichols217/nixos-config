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
      fsType = "tmpfs";
    };
  };

  services.httpd = {
    enable = true;
    adminAddr = "Pathway2PBC@gmail.com";
    virtualHosts = let 
      defHost = host: {
        addSSL = true;
        documentRoot = "/storage/church/Public";
        sslServerKey = "/var/lib/acme/acme-challenge/${host}/key.pem";
        sslServerCert = "/var/lib/acme/acme-challenge/${host}/fullchain.pem";
      };
    in {
      "heyo.ydns.eu" = defHost "heyo.ydns.eu";
      "pigsgo.mooo.com" = defHost "pigsgo.mooo.com";
    };
  };
}