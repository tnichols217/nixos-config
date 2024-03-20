{ pkgs, attrs, config, addresses, ... }:
{
  # networking.wireless = {
  #   enable = true;
  #   userControlled.enable = true;
  #   networks = {
  #     "NICHOLS 5Ghz" = {
  #       psk = "0194815801";
  #     };
  #   };
  # };

  networking = {

    useNetworkd = true;
    nftables.enable = true;

    # bridges.brwg.interfaces = [ ];

    # interfaces.brwg.useDHCP = false;
    # interfaces.brwg.ipv4.addresses = [{
    #   address = "10.0.2.1";
    #   prefixLength = 24;
    # }];

    networkmanager.unmanaged = [ "interface-name:ve-*" ];

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" "vb-+" "brwg" ];
      # internalIPs = [ "10.0.1.0/24" ];
      # internalInterfaces = [ "ve-sonarr" "ve-prowlarr" "ve-transmission" "ve-lidarr" "ve-jellyfin" "ve-radarr" "ve-readarr" ];
      externalInterface = "enp7s0";
      enableIPv6 = true;
    };
  };

  systemd.services."ssh-tunnel" = {
    serviceConfig = {
      RestartSec = "5";
      Restart = "always";
    };
    path = with pkgs; [ nix ];
    script = ''
      ${pkgs.openssh}/bin/ssh -NR 4430:localhost:443 -R 8000:localhost:80 -R 2200:localhost:22 -R 25565:localhost:25565 ec2-user@${addresses.default} -i /var/lib/mullvad/ec2.cert
    '';
    wantedBy = ["multi-user.target"];
  };

  systemd.network = {
    enable = true;
    netdevs = {
      # "20-brwg" = {
      #   netdevConfig = {
      #     Kind = "bridge";
      #     Name = "brwg";
      #   };
      # };
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };
        wireguardConfig = {
          PrivateKeyFile = "/var/lib/mullvad/priv";
        };
        wireguardPeers = [
          {
            wireguardPeerConfig = {
              PublicKey = "0qSP0VxoIhEhRK+fAHVvmfRdjPs2DmmpOCNLFP/7cGw=";
              AllowedIPs = ["0.0.0.0/0" "::0/0"];
              Endpoint = "193.32.248.66:51820";
            };
          }
        ];
      };
    };
    networks = {
      "10-wg0" = {
        matchConfig.Name = "wg0";
        # networkConfig.Bridge = "brwg";
        linkConfig.RequiredForOnline = "yes";
        address = ["10.67.135.222/32" "fc00:bbbb:bbbb:bb01::4:87dd/128"];
        dns = ["10.64.0.1"];
        networkConfig = {
          IPMasquerade = "both";
          # IPForward = true;
        };
        routes = [
          {
            Gateway = "10.64.0.1";
            Destination = "10.64.0.0/16";
            GatewayOnLink = "yes";
          }
        ];
        DHCP = "no";
      };
      # "10-ve" = {
      #   matchConfig = {
      #     Kind = "veth";
      #     Name = "ve-*";
      #   };
      #   networkConfig = {
      #     IPMasquerade = "both";
      #   };
      # };
      # "40-br0" = {
      #   matchConfig.Name ="brwg";
      #   bridgeConfig = {};
      #   linkConfig.RequiredForOnline = "no";
      # };
    };
  };
}