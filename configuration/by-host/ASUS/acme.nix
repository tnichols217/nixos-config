{ pkgs, attrs, config, addresses, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      webroot = "/var/lib/acme/acme-challenge";
      email = "62992267+tnichols217@users.noreply.github.com";
      group = "nginx";
    };
    certs = {
      "${addresses.heyo}" = {};
      "${addresses.pigs}" = {};
      "${addesses.asus}" = {};
    };
  };
}