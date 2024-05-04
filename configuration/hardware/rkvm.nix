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
          "left-alt"
          "left-meta"
          "left-ctrl"
        ];
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
        server = "${addresses.asus}:${toString ports.rkvm}";
        password = "0123456789";
      };
    };
  };
} (if host-name == "ASUS" then {
  systemd.services."rkvm-gen" = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ rkvm ];
    script = ''
      ${pkgs.rkvm}/bin/rkvm-certificate-gen -d ${host-name} -d ${addresses.asus} -d tln32asus ${cert} ${key}
      chmod 777 ${cert}
    '';
    wantedBy = ["rkvm-server.service" "rkvm-server.service"];
  };
} else {
  systemd.services."rkvm-copy" = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ rkvm ];
    script = ''
      ${pkgs.openssh}/bin/scp -i /home/tev/.ssh/ed25519 tev@${addresses.asus}:${cert} ${cert}
    '';
    wantedBy = ["rkvm-server.service" "rkvm-server.service"];
  };
})]