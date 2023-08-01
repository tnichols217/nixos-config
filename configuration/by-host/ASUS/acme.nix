{ pkgs, attrs, config, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      webroot = "/var/lib/acme/acme-challenge";
      email = "62992267+tnichols217@users.noreply.github.com";
      group = "wwwrun";
    };
    certs = {
      "heyo.ydns.eu" = {};
      "pigsgo.mooo.com" = {};
    };
  };
}