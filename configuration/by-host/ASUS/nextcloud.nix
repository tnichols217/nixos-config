{ pkgs, attrs, config, ... }:
{
  services.postgresql = {
    enable = true;

    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];
  };

  services.nextcloud = {
    enable = true;
    hostName = "pigsgo.mooo.com";
    # nginx.enable = true;

    https = true;
    
    autoUpdateApps.enable = true;
    autoUpdateApps.startAt = "05:00:00";

    config = {
      overwriteProtocol = "https";

      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      dbpassFile = "/var/nextcloud-db-pass";

      adminpassFile = "/var/nextcloud-admin-pass";
      adminuser = "admin";
 };
};
}