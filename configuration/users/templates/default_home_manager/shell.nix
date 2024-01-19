{ pkgs, attrs, username, host-name, version, lib, nix-index-database, ... }:
{
  imports = [
    ./shell/kitty.nix
    ./shell/comma.nix
    ./shell/fish.nix
    ./shell/zsh.nix
  ];

  users.users.${username} = {
    shell = pkgs.zsh;
  };

  environment.pathsToLink = [ "/share/zsh" ];

  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
          bat
          lsd
          xclip
      ];
    };
    programs = {
      git = {
        enable = true;
        userName = "tnichols217";
        userEmail = "62992267+tnichols217@users.noreply.github.com";
        diff-so-fancy = {
          enable = true;
        };
        lfs = {
          enable = true;
        };
        extraConfig = {
          credential = {
            helper = "store";
          };
        };
      };
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings.git_protocol = "ssh";
      };
      fzf = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
      };
      direnv = {
        enable = true;
        config = {
          global = {
            disable_stdin = true;
          };
        };
        nix-direnv = {
          enable = true;
        };
      };
    };
  };
}
