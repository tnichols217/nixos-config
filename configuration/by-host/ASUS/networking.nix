{ pkgs, attrs, config, ... }:
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

  systemd.network = {
    enable = true;
    netdevs = {
      "20-brwg" = {
        netdevConfig = {
          Kind = "bridge";
          Name = "brwg";
        };
      };
      "50-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1300";
        };
        wireguardConfig = {
          PrivateKeyFile = "/var/lib/mullvad/priv";
          ListenPort = 51820;
        };
        wireguardPeers = [
          {
            wireguardPeerConfig = {
              PublicKey = "0qSP0VxoIhEhRK+fAHVvmfRdjPs2DmmpOCNLFP/7cGw=";
              AllowedIPs = ["10.67.135.222/32" "fc00:bbbb:bbbb:bb01::4:87dd/128"];
              Endpoint = "193.32.248.66:51820";
            };
          }
        ];
      };
    };
    networks = {
      wg0 = {
        matchConfig.Name = "wg0";
        networkConfig.Bridge = "brwg";
        linkConfig.RequiredForOnline = "no";
        address = ["10.100.0.1/24"];
        networkConfig = {
          IPMasquerade = "ipv4";
          IPForward = true;
        };
      };
      "40-br0" = {
        matchConfig.Name ="brwg";
        bridgeConfig = {};
        linkConfig.RequiredForOnline = "no";
      };
    };
  };
}