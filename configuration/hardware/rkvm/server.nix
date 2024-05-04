{ ports, ... }:
''
listen = "0.0.0.0:${ports.rkvm}"
switch-keys = ["left-alt", "left-ctrl"]
propagate-switch-keys = true
certificate = "/etc/rkvm/certificate.pem"
key = "/etc/rkvm/key.pem"
password = "123456789"
''