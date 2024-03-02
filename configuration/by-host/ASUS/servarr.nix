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

    users.users."${un}".extraGroups = [ "${group}" ];
  };

}