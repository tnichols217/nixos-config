{ pkgs, addresses, ... }:
{
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
    '';
    settings = {
      trusted-substituters = [
        "https://cache.garnix.io"
        "https://cache.nixos.org/"
        "https://raspberry-pi-nix.cachix.org"
        "https://tnichols217-nixos-config.cachix.org"
        "https://${addresses.serve}"
      ];
      trusted-public-keys = [
        "tnichols217-nixos-config.cachix.org-1:B9JhBiPS+OHykLW16qovoOelAvtdH5sIjYU7BZvs7q8="
        "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
        "${addresses.serve}:bJbLksSatz2ycQ7uZmT5/kmW6bhloYHr0/36lvcQ3bk="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      auto-optimise-store = true;
      trusted-users = [ "tev" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
}