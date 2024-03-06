{ lib, ... }:
{
  services.clamav.daemon = {
    enable = true;
    settings = {
      User = lib.mkForce "root";
    };
  };
}