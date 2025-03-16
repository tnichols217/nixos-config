{ host-name, lib, ports, addresses, pkgs, ... }:
let
  path = "/var/lib/rkvm";
  cert = "${path}/certificate.pem";
  key = "${path}/key.pem";
in
lib.mkMerge [
{
  systemd.tmpfiles.rules = [
    "d ${path} 0777 root root"
    "z ${path} 0777 root root"
  ];

  services.rkvm = {
    server = {
      enable = if host-name == "ASUS" then true else false;
      settings = {
        switch-keys = [
          "left-meta"
          "left-ctrl"
          "f13"
        ];
        propagate-switch-keys = true;
        key = "${key}";
        certificate = "${cert}";
        listen = "0.0.0.0:${toString ports.rkvm}";
        password = "0123456789";
      };
    };
    client = {
      enable = if host-name == "ASUS" then false else true;
      settings = {
        certificate = "${cert}";
        server = "localhost:${toString ports.rkvm}";
        password = "0123456789";
      };
    };
  };
} (if host-name == "ASUS" then {
  systemd.services."rkvm-gen" = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ rkvm ];
    script = ''
      ${pkgs.rkvm}/bin/rkvm-certificate-gen -d ${host-name} -d ${addresses.asus} -d tln32asus -d ${addresses.default} -d localhost ${cert} ${key}
      chmod 777 ${cert}
    '';
    wantedBy = ["rkvm-server.service"];
  };
} else {
  systemd.services."rkvm-copy" = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ rkvm ];
    script = ''
      ${pkgs.openssh}/bin/scp -P ${toString ports.ssh} -i /home/tev/.ssh/ed25519 tev@${addresses.default}:${cert} ${cert}
    '';
    wantedBy = ["rkvm-client.service"];
  };
  systemd.services."rkvm-tunnel" = {
    serviceConfig = {
      RestartSec = "5";
      Restart = "always";
    };
    path = with pkgs; [ nix ];
    script = ''
      ${pkgs.openssh}/bin/ssh -NL ${toString ports.rkvm}:localhost:${toString ports.rkvm} tev@${addresses.default} -p ${toString ports.ssh} -i /home/tev/.ssh/ed25519
    '';
    wantedBy = ["rkvm-client.service"];
  };
})]