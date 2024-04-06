{ pkgs, attrs, config, username, addresses, ... }:
{
  # systemd.services."${username}@sunshine" = {
  #   serviceConfig.Type = "simple";
  #   path = with pkgs; [ pkgs.sunshine ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.sunshine}/bin/sunshine";
  #     Restart = "on-failure";
  #   };
  #   serviceConfig = {
  #     Environment = "\"HOME=/home/${username}\" XDG_CONFIG_HOME=/home/${username}/.config";
  #   };
  #   wantedBy = ["multi-user.target"];
  # };
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
  
} // (if (host-name == "ASUS") then {
  systemd.services."synergy" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ pkgs.synergy ];
    serviceConfig = {
      ExecStart = "${pkgs.synergy}/bin/synergys -c ${./services/synergy/ASUS.conf}";
      Restart = "on-failure";
    };
    serviceConfig.User = "${username}";
    wantedBy = ["multi-user.target"];
  };
} else {
  systemd.services."waynergy" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ pkgs.waynergy ];
    serviceConfig = {
      ExecStart = "${pkgs.waynergy}/bin/waynergy -b wlr -N ${host-name} -E -c ${addresses.asus}";
      Restart = "on-failure";
    };
    serviceConfig.User = "${username}";
    wantedBy = ["multi-user.target"];
  };
})