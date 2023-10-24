{ pkgs, attrs, config, username, ... }:
{
  systemd.services."${username}@sunshine" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ pkgs.sunshine ];
    serviceConfig = {
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
      Restart = "on-failure";
    };
    serviceConfig = {
      User = "${username}";
      Group = "root";
    };
    wantedBy = ["multi-user.target"];
  };
  systemd.services."${username}@cachix" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ pkgs.cachix ];
    serviceConfig = {
      ExecStart = "${pkgs.cachix}/bin/cachix watch-store tnichols217-nixos-config";
      Restart = "on-failure";
    };
    serviceConfig.User = "${username}";
    wantedBy = ["multi-user.target"];
  };
}