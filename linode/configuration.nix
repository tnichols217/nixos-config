{ config, lib, pkgs, host-name, ... }:

{
  networking.hostName = host-name;

  time.timeZone = "America/Toronto";

  environment.noXlibs = true;

  users.users.root = {
    hashedPassword = "!";
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINILZDzRLWHEXbtv0TfEH+mNG8mN1nN8C7IXT0cqZqWm tev@ROG"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwL6Uvhyr+mrXDPcM+d3AUD5l0eN2DoN+UqIHBWntB+ tev@ASUS"
    ];
  };

  environment.systemPackages = with pkgs; [
    nano
    coreutils
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      GatewayPorts = "yes";
    };
  };

  networking = { 
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22      # SSH
        80      # HTTP
        443     # HTTPS
        2200    # SSH
        25565   # Minecraft
      ];
    };
  };
  
  system.stateVersion = "24.05";
}
