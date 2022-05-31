{ config, pkgs, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.enableHidpi = true;
  services.xserver.displayManager.sddm.theme = "${(pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "kde-plasma-chili";
    rev = "latest";
    # sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
})}";
#   services.xserver.displayManager.sddm.theme = "${builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz"}";
  services.xserver.desktopManager.plasma5.enable = true;
}