{ ... } :
let
  group = "rtorrent";
  un = "lidarr";
in
{
  services = {
    lidarr = {
      enable = true;
      user = "${un}";
      dataDir = "/var/lib/lidarr/.config/Lidarr";
    };
    rtorrent = {
      enable = true;
      group = "${group}";
    };
    prowlarr = {
      enable = true;
    };
    jellyfin = {
      enable = true;
    };
  };

  virtualisation.oci-containers.containers = {
    flaresolverr = {
      imageFile = pkgs.dockerTools.pullImage{
        imageName = "flaresolverr/flaresolverr";
        finalImageTag = "v3.3.16";
        imageDigest = "sha256:35feb16defbc4a0012143ec14e7eabdf361a1a1f31075db49e85ccd8cc1ee485";
        sha256 = "000rsk86w398v9gdf1r2vy1b9190kimqmlnifsnj16nxk0bma1f4";
      };
    };
  };


  users.users."${un}".extraGroups = [ "${group}" ];

}