{ pkgs, attrs, ... }:
{
  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    networks = {
      "NICHOLS 5Ghz" = {
        psk = "0194815801";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      webroot = "/var/lib/acme/acme-challenge";
      email = "62992267+tnichols217@users.noreply.github.com";
      group = "wwwrun";
    };
    certs = {
      "heyo.ydns.eu" = {};
      "pigsgo.mooo.com" = {};
    };
  };

  services.httpd = {
    enable = true;
    adminAddr = "Pathway2PBC@gmail.com";
    # group = "acme";
    virtualHosts = let 
      defHost = host: {
        addSSL = true;
        documentRoot = "/storage/church/Public";
        useACMEHost = "${host}";
      };
    in {
      "heyo.ydns.eu" = defHost "heyo.ydns.eu";
      "pigsgo.mooo.com" = defHost "pigsgo.mooo.com";
    };
  };

  services.cron = {
    enable = true;
    systemCronJobs = [ ''0,5,10,15,20,25,30,35,40,45,50,55 * * * * root sh /storage/church/config/update.sh'' ];
  };

  services.openvpn.servers = let 
    configString = {adapt, port?"1194"}:
      let 
        # easyrsa init-pki
        # easyrsa build-ca
        ca = "/var/lib/openvpn/pki/ca.crt";
        # easyrsa build-server-full server
        cert = "/var/lib/openvpn/pki/issued/server.crt";
        key = "/var/lib/openvpn/pki/private/server.key";
        # openssl dhparam -out dh2048.pem 2048
        dh = "/var/lib/openvpn/dh2048.pem";
        # openvpn --genkey tls-auth ta.key
        ta = "/var/lib/openvpn/ta.key";
        log = "openvpn-status.log";
      in ''
        port ${port}
        proto udp

        dev ${adapt}
        push "redirect-gateway def1"
        push "dhcp-option DNS 8.8.8.8"
        push "dhcp-option DNS 8.8.4.4"

        # SSL/TLS root certificate (ca)
        ca ${ca}
        # server certificate
        cert ${cert}
        # server private key
        key ${key}

        # Diffie hellman parameters.
        # Generate your own with:
        #   openssl dhparam -out dh2048.pem 2048
        dh ${dh}

        tls-auth ${ta} 0

        # Configure server mode and supply a VPN subnet
        # for OpenVPN to draw client addresses from.
        server 10.8.0.0 255.255.255.0

        # Maintain a record of client <-> virtual IP address
        ifconfig-pool-persist ipp.txt

        keepalive 10 120

        max-clients 5
        user nobody
        group nobody
        persist-key
        persist-tun

        # Log verbosity 0-9
        verb 3
        status ${log}

        # Notify the client that when the server restarts
        explicit-exit-notify 1

        # Uncomment to allow clients to be able to "see" each other.
        ;client-to-client

        # Uncomment this directive if multiple clients
        # might connect with the same certificate/key
        ;duplicate-cn
      '';
  in {
    serverTun = {
      config = configString{adapt = "tun"; port = "1195";};
      up = "iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o wlo1 -j MASQUERADE; ${pkgs.procps}/bin/sysctl -w net.ipv4.ip_forward=1";
    };
    serverTap = {
      config = configString{adapt = "tap";};
    };
  };

  fileSystems = {
    # server drive
    "/storage" = {
      device = "/dev/disk/by-label/WEBSTORAGE";
      fsType = "ext4";
      neededForBoot = false;
    };
    "/lgass" = {
      device = "/dev/disk/by-label/LGASS";
      fsType = "ext4";
      neededForBoot = false;
    };
  };

  nixpkgs.overlays = [
    attrs.minecraft-arion.overlays.x86_64-linux
  ];

  virtualisation.arion = {
    backend = "podman-socket";
    projects.minecraft.settings = {
      imports = [ attrs.minecraft-arion.arion-module ];
    };
  };

  # TODO move pipewire config to config files instead

  # services.pipewire = {
  #   config = {
  #     pipewire = {
  #       "context.modules" = [
  #         {
  #           name = "libpipewire-module-rt";
  #           args = {
  #             "nice.level" = -11;
  #           };
  #           flags = [ "ifexists" "nofail" ];
  #         }
  #         { name = "libpipewire-module-protocol-native"; }
  #         { name = "libpipewire-module-profiler"; }
  #         { name = "libpipewire-module-metadata"; }
  #         { name = "libpipewire-module-spa-device-factory"; }
  #         { name = "libpipewire-module-spa-node-factory"; }
  #         { name = "libpipewire-module-client-node" ;}
  #         { name = "libpipewire-module-client-device"; }
  #         {
  #           name = "libpipewire-module-portal";
  #           flags = [ "ifexists" "nofail" ];
  #         }
  #         {
  #           name = "libpipewire-module-access";
  #           args = {};
  #         }
  #         { name = "libpipewire-module-adapter"; }
  #         { name = "libpipewire-module-link-factory"; }
  #         { name = "libpipewire-module-session-manager"; }
  #         {
  #           name = "libpipewire-module-pulse-tunnel";
  #           args = {
  #             "tunnel.mode" = "sink";
  #             "pulse.server.address" = "tcp:192.168.100.250";
  #           };
  #         }
  #         {
  #           name = "libpipewire-module-zeroconf-discover";
  #           args = {};
  #         }
  #       ];
  #     };
  #   };
  # };

  services.nix-serve = {
    enable = true;
  };

  hardware.nvidia = {
    prime.nvidiaBusId = "PCI:1:0:0";
    modesetting.enable = true;
  };
}