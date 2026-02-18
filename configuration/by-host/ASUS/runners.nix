{ ... }:
let
  user = "github-runner";
  mkrunner = {name, url, token}: {
    systemd.tmpfiles.rules = [
      "d /var/lib/github-runner-${name} 0750 ${user} ${user} -"
    ];
    services.github-runners = {
      "${name}" = {
        enable = true;
        inherit name url user;
        tokenFile = token;
        ephemeral = true;
        replace = true;
      };
    };
  };
in {
  imports = [
    (mkrunner {
      name = "nixos1";
      url = "https://github.com/tnichols217/nixos-config";
      token = "/var/lib/secrets/nixos-config";
    })
    (mkrunner {
      name = "nixos2";
      url = "https://github.com/tnichols217/nixos-config";
      token = "/var/lib/secrets/nixos-config";
    })
  ];
  users.groups."${user}" = {};

  users.users."${user}" = {
    isSystemUser = true;
    group = user;
    description = "GitHub Actions Runner";
    createHome = false;
    extraGroups = [ ];
  };

  nix.settings.trusted-users = [
    user
  ];
}