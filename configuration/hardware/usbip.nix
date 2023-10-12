{ pkgs, attrs, config, ... }:
{
  systemd.services."usbipd" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ config.boot.kernelPackages.usbip ];
    serviceConfig = {
      ExecStart = "${config.boot.kernelPackages.usbip}/bin/usbipd";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
  };
}