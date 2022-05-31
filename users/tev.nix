{ config, pkgs, ... }:
{
  users.users.tev = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';
  };

  home-manager.users.tev = {
    home = {
      stateVersion = "21.11";
      packages = with pkgs; [
        vscodium
        obsidian
        barrier
        gnupg
      ];
    };
    programs = {
      git = {
        enable = true;
        userName = "tnichols217";
        userEmail = "62992267+tnichols217@users.noreply.github.com";
      };
      fish = {
        enable = true;
        plugins = [
          {
            name = "fzf";
            src = pkgs.fetchFromGitHub {
              owner = "jethrokuan";
              repo = "fzf";
              rev = "ac01d96fc6344ebeb48c03f2c9c0be5bf3b20f1c";
              sha256 = "1h97zh3ghcvvn2x9rj51frhhi85nf7wa072g9mm2pc6sg71ijw4k";
            };
          }
        ];
        shellAliases = {
          clip = "xclip -selection clipboard -r";
          gac = "git add -A && git commit -am ";
          gp = "git push ";
          gpl = "git pull ";
        };
      };
    };
    firefox = {
      enable = true;
      package = nur.repos.wolfangaukang.librewolf-bin;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        https-everywhere
        privacy-badger
        darkreader
        ublock-origin
        sponsorblock
        videospeed
      ];
    };
  };
}