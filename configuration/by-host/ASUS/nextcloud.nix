{ pkgs, attrs, config, lib, ... }:
{
  services.postgresql = {
    enable = true;

    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  services.nextcloud = {
    enable = true;
    hostName = "tln32asus.student.cwru.edu";
    package = pkgs.nextcloud27;
    configureRedis = true;
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
      dbpassFile = "/var/lib/nextcloud/db-pass";

      adminpassFile = "/var/lib/nextcloud/admin-pass";
      adminuser = "admin";
    };
    phpOptions = {
      upload_max_filesize = lib.mkForce "64G";
      post_max_size = lib.mkForce "64G";
    };
  };
}