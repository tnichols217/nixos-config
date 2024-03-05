{ ... }:
{
  services.clamav.daemon = {
    enable = true;
    settings = {
      User = "root";
    };
  };
}