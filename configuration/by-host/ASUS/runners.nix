{ ... }:
{
  services.github-runners = {
    runner1 = {
      enable = true;
      name = "nixos1";
      tokenFile = "/var/lib/secrets/nixos-config";
      ephemeral = true;
      url = "https://github.com/tnichols217/nixos-config";
    };
    runner2 = {
      enable = true;
      name = "nixos2";
      tokenFile = "/var/lib/secrets/nixos-config";
      ephemeral = true;
      url = "https://github.com/tnichols217/nixos-config";
    };
  }
}