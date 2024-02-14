{ pkgs, attrs, config, ... }:
{
  systemd.services."generate-nix-serve-certs" = {
    # FIXME
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ nix ];
    script = ''
      if [ ! -f "/var/lib/nix-serve/cache-priv-key.pem" ] || [ ! -f "/var/lib/nix-serve/cache-pub-key.pem" ]; then
        nix-store --generate-binary-cache-key pigsgo.mooo.com /var/lib/nix-serve/cache-priv-key.pem /var/lib/nix-serve/cache-pub-key.pem
        chown nix-serve /var/lib/nix-serve/cache-priv-key.pem
        chmod 600 /var/lib/nix-serve/cache-priv-key.pem
      fi
    '';
    wantedBy = ["multi-user.target"];
    
  };

  services.nix-serve = {
    enable = true;
    port = 4999;
  };

}