{ pkgs, config, ... }:
{
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
}