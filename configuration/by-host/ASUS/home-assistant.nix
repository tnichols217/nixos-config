{ ports, ... }:
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "esphome"
      "met"
      "radio_browser"
      "tplink"
    ];
    extraPackages =  python3Packages: with python3Packages; [
      psycopg2
      numpy
      aiodhcpwatcher
      aioesphomeapi
      aiohttp-cors
      aiodiscover
      ifaddr
      zeroconf
    ];
    configDir = "/var/lib/hass";
    config = {
      http = {
        use_x_forwarded_for = true;
        trusted_proxies = [ "127.0.0.1" "::1" ];
        ip_ban_enabled = true;
        login_attempts_threshold = 5;
        server_port = ports.home-assistant;
      };
      homeassistant.unit_system = "metric";
    };
  };
}