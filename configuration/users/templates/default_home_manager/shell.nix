{ pkgs, username, host-name, version, lib, nix-index-database, ... }@ args:
{
  imports = [
    (import ./shell/kitty.nix args)
    (import ./shell/comma.nix args)
    (import ./shell/zsh.nix args)
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
      shell = {
        enableShellIntegration = true;
        enableFishIntegration = false;
      };
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
          commit.gpgsign = true;
          gpg.format = "ssh";
          gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
          user.signingkey = "~/.ssh/ed25519.pub";
        };
      };
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings.git_protocol = "ssh";
      };
      fzf = {
        enable = true;
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
