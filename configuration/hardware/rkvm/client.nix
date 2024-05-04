{ addresses, ports, ... }:
''
server = "${addresses.asus}:${ports.rkvm}"
certificate = "/etc/rkvm/certificate.pem"
password = "123456789"
''