{ pkgs, attrs, config, username, ... }:
{
  systemd.services."${username}@sunshine" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ config.boot.kernelPackages.sunshine ];
    serviceConfig = {
      ExecStart = "${config.boot.kernelPackages.sunshine}/bin/sunshine";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
  };
}