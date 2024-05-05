{ config, lib, pkgs, host-name, ... }:

{
  networking.hostName = host-name;

  time.timeZone = "America/Toronto";

  environment.noXlibs = true;

  users.users.root = {
    # isNormalUser = true;
    # extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "!";
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINILZDzRLWHEXbtv0TfEH+mNG8mN1nN8C7IXT0cqZqWm tev@ROG"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
  networking.firewall.enable = false;
  system.stateVersion = "24.05"; # Did you read the comment?
}
