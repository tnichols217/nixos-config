{ config, pkgs, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.enableHidpi = true;
  services.xserver.displayManager.sddm.theme = "${(pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "kde-plasma-chili";
    rev = "a371123959676f608f01421398f7400a2f01ae06";
    sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
})}";
#   services.xserver.displayManager.sddm.theme = "${builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz"}";
  services.xserver.desktopManager.plasma5.enable = true;
}