{ ... }:
{
  services.openvpn.servers = let 
    configString = {adapt}: 
      let 
        addr = "pigsgo.mooo.com";
        # get from server
        ca = "/var/lib/openvpn/ca.crt";
        # easyrsa build-client-full client
        cert = "/var/lib/openvpn/client.crt";
        key = "/var/lib/openvpn/client.key";
        # get from server
        ta = "/var/lib/openvpn/ta.key";
      in ''
        client

        dev ${adapt}

        ;proto tcp
        proto udp
        
        remote ${addr} 1194
        
        resolv-retry infinite

        nobind

        user nobody
        group nobody
        persist-key
        persist-tun

        ca ${ca}
        cert ${cert}
        key ${key}

        tls-auth ${ta} 1

        cipher AES-256-CBC

        # Set log file verbosity.
        verb 3
      '';
  in {
    clientTun = {
      config = configString{adapt = "tun";};
    };
    clientTap = {
      config = configString{adapt = "tap";};
    };
  };
}