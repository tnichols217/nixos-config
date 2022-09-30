{ pkgs, attrs, username, host-name, version, ... }:
{
  users.users.${username} = {
    shell = pkgs.fish;
  };

  home-manager.users.${username} = {
    home = {
      stateVersion = version;
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
      };
      fish = {
        enable = true;
        shellAliases = {
          clip = "xclip -selection clipboard -r";
          gac = "git add -A && git commit -am ";
          gp = "git push ";
          gpl = "git pull ";
          gs = "git submodule ";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          cdg = "cd $(git rev-parse --show-toplevel)";
          upg = "sudo bash -c \"rm /home/${username}/.gtkrc-2.0 /home/${username}/.config/plasma-org.kde.plasma.desktop-appletsrc; cd /etc/nixos; git stash; git stash clear; git pull; nixos-rebuild switch --flake \\\".#${host-name}\\\"\"";
          sci = "ssh-copy-id -i ~/.ssh/ed25519 ";
          pathof = "path resolve ";
          code = "codium";
          c = "codium .";
          rssound = "systemctl --user restart pipewire";
          ls = "lsd";
          ca = "bat";
          da = "direnv allow";
        };
        functions = {
          gc = "git clone git@github.com:tnichols217/$argv";
          gacp = "git add -A && git commit -am $argv; git push";
          unpersist = "set TEMPFILE (mktemp); cp $argv $TEMPFILE; rm $argv; cp $TEMPFILE $argv; rm $TEMPFILE";
          gm = "set CURBRANCH (git branch --show-current); git checkout $argv; git merge $CURBRANCH; git push; git checkout $CURBRANCH";
        };
        plugins = [
          {
            name = "theme-bobthefish";
            src = attrs.btf;
          }
        ];
      };
      fzf = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
      };
      gh = {
        enable = true;
        enableGitCredentialHelper = true;
        settings.git_protocol = "ssh";
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
