{ config, lib, pkgs, host-name, attrs, ... }@args :
{
  imports = [
    ./configuration/disks.nix
    ((import ../configuration/users/templates/persist.nix) (args // { username = "user"; }))
    ((import ../configuration/users/templates/normal_sudo.nix) (args // { username = "user"; }))
  ];

  networking.hostName = host-name;

  time.timeZone = "Asia/Kuala_Lumpur";

  # environment.noXlibs = true;

  users.users = {
    root = {
      hashedPassword = lib.mkForce "!";
      packages = with pkgs; [
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINILZDzRLWHEXbtv0TfEH+mNG8mN1nN8C7IXT0cqZqWm tev@ROG"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwL6Uvhyr+mrXDPcM+d3AUD5l0eN2DoN+UqIHBWntB+ tev@ASUS"
      ];
    };

    user = {
      hashedPassword = ''$y$j9T$3l9ddjue6Mjm4IInm6JDV.$O1sVWAOlnxsF//uh1euVEFPCyh7AD8lCYBIfWMKe4L6'';
      packages = with pkgs; [
        (callPackage ../configuration/users/tev/packages/firefox.pkg.nix { inherit attrs config; })
        qbittorrent
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINILZDzRLWHEXbtv0TfEH+mNG8mN1nN8C7IXT0cqZqWm tev@ROG"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwL6Uvhyr+mrXDPcM+d3AUD5l0eN2DoN+UqIHBWntB+ tev@ASUS"
      ];
    };
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
      ];
    };
  };
  
  system.stateVersion = "24.05";
}
