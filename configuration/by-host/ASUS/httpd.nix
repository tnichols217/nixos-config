{ pkgs, attrs, config, ... }:
{
  services.httpd = {
    enable = true;
    adminAddr = "Pathway2PBC@gmail.com";
    # group = "acme";
    virtualHosts = let 
      defHost = host: {
        addSSL = true;
        documentRoot = "/storage/church/Public";
        useACMEHost = "${host}";
      };
    in {
      "heyo.ydns.eu" = defHost "heyo.ydns.eu";
      "pigsgo.mooo.com" = defHost "pigsgo.mooo.com";
    };
  };
}