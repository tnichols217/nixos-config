{ pkgs, attrs, config, addresses, ... }:
{
  security.acme = {
    acceptTerms = true;
    defaults = {
      # webroot = "/var/lib/acme/acme-challenge";
      email = "62992267+tnichols217@users.noreply.github.com";
      group = "nginx";
    };
    certs = {
      "${addresses.default}" = {};
      "${addresses.serve}" = {};
      "${addresses.nextcloud}" = {};
      "${addresses.lidarr}" = {};
      "${addresses.radarr}" = {};
      "${addresses.sonarr}" = {};
      "${addresses.readarr}" = {};
      "${addresses.prowlarr}" = {};
      "${addresses.jellyfin}" = {};
    };
  };
}