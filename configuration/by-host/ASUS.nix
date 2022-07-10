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
        useACMEHost = "/var/lib/acme/${host}";
      };
    in {
      "heyo.ydns.eu" = defHost "heyo.ydns.eu";
      "pigsgo.mooo.com" = defHost "pigsgo.mooo.com";
    };
  };
}