{ config, lib, pkgs, host-name, version, inputs, ... }@args :
{
  imports = [
    # ./configuration/disks.nix
    ./configuration/hardware.nix
    ./configuration/disks.nix
    ../configuration/x11/greetd.nix
    ../configuration/x11/hyprland.nix
    ((import ../configuration/users/templates/persist.nix) (args // { username = "user"; }))
    ((import ../configuration/users/templates/normal_sudo.nix) (args // { username = "user"; }))
    ((import ../configuration/users/templates/default_home_manager.nix) (args // { username = "user"; }))
  ];

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
        (callPackage ../configuration/users/tev/packages/firefox.pkg.nix { inherit inputs config; })
        qbittorrent
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINILZDzRLWHEXbtv0TfEH+mNG8mN1nN8C7IXT0cqZqWm tev@ROG"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwL6Uvhyr+mrXDPcM+d3AUD5l0eN2DoN+UqIHBWntB+ tev@ASUS"
      ];
    };
    
  };

  home-manager.users.user = {
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };


  environment.systemPackages = with pkgs; [
    nano
    coreutils
    networkmanager
    bluez
    bluez-tools
    kitty
    ungoogled-chromium
    fastfetch
    yewtube
    qbittorrent
  ];

  programs = {
    zsh.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      GatewayPorts = "yes";
    };
  };

  networking = {
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };

    hostName = host-name;
    # useDHCP = false;
    # interfaces = { wlan0.useDHCP = true; };
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

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
    '';
    settings = {
      trusted-substituters = [
        "https://cache.garnix.io"
        "https://cache.nixos.org/"
        "https://raspberry-pi-nix.cachix.org"
        "https://tnichols217-nixos-config.cachix.org"
      ];
      trusted-public-keys = [
        "tnichols217-nixos-config.cachix.org-1:B9JhBiPS+OHykLW16qovoOelAvtdH5sIjYU7BZvs7q8="
        "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      auto-optimise-store = true;
      trusted-users = [ "tev" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    enableDefaultPackages = true;
  };

  system.stateVersion = version;
}

