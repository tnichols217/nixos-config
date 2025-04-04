{ pkgs, config, addresses, ports, ... }:
{
  systemd.services."generate-nix-serve-certs" = {
    # FIXME
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ nix ];
    script = ''
      if [ ! -f "/var/lib/nix-serve/cache-priv-key.pem" ] || [ ! -f "/var/lib/nix-serve/cache-pub-key.pem" ]; then
        nix-store --generate-binary-cache-key ${addresses.serve} /var/lib/nix-serve/cache-priv-key.pem /var/lib/nix-serve/cache-pub-key.pem
        chown root /var/lib/nix-serve/cache-priv-key.pem
        chmod 666 /var/lib/nix-serve/cache-priv-key.pem
      fi
    '';
    wantedBy = ["multi-user.target"];
    
  };

  services.nix-serve = {
    enable = true;
    port = ports.serve;
    secretKeyFile = "/var/lib/nix-serve/cache-priv-key.pem";
  };
}