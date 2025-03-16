{ config, lib, pkgs, host-name, ports, ... }:

{
  networking.hostName = host-name;

  time.timeZone = "America/Toronto";

  users.users = {
    root = {
      hashedPassword = "!";
      packages = with pkgs; [
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINILZDzRLWHEXbtv0TfEH+mNG8mN1nN8C7IXT0cqZqWm tev@ROG"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwL6Uvhyr+mrXDPcM+d3AUD5l0eN2DoN+UqIHBWntB+ tev@ASUS"
      ];
    };
    ports = {
      hashedPassword = "!";
      isNormalUser = true;
      home = "/home/ports";
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINILZDzRLWHEXbtv0TfEH+mNG8mN1nN8C7IXT0cqZqWm tev@ROG"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwL6Uvhyr+mrXDPcM+d3AUD5l0eN2DoN+UqIHBWntB+ tev@ASUS"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    inetutils
    mtr
    sysstat
    nano
    coreutils
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      GatewayPorts = "yes";
      # PermitRootLogin = "yes";
    };
  };

  networking = { 
    usePredictableInterfaceNames = false;
    useDHCP = lib.mkForce false;
    interfaces.eth0.useDHCP = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = with ports; [
        22      # SSH
        80      # HTTP
        443     # HTTPS
        ssh     # SSH
        25565   # Minecraft
      ];
    };
  };

  boot = {
    kernelParams = [ "console=ttyS0,19200n8" ];
    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };
    loader = {
      grub = {
        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output serial
        '';
        device = "nodev";
      };
      timeout = 10;
    };
  };
  
  system.stateVersion = "24.05";
}
