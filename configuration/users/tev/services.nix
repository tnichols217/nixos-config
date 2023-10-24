{ pkgs, attrs, config, username, ... }:
{
  systemd.services."${username}@sunshine" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ pkgs.sunshine ];
    serviceConfig = {
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
  };
}