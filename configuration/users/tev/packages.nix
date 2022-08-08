{ config, pkgs, username, attrs, host-name, vscodeExtensions,... }:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # utils
        cachix
        libsForQt5.qt5.qttools
        gnupg
        ibus
        ibus-engines.uniemoji
        ibus-engines.libpinyin
        fswatch
        python3
        konsole
        meld
        neofetch
        gparted
        docker
        yarn
        nodejs
        nodePackages.nodemon
        nodePackages.npm
        openjdk16-bootstrap
        virt-manager
        bat
        lsd
        xclip
        helvum
        ark
        nerdfonts
        pstree

        # programs
        filezilla
        filelight
        libreoffice
        davinci-resolve
        kicad-unstable
        lolcat
        htop
        libsForQt5.kdeconnect-kde

        obsidian
        config.nur.repos.wolfangaukang.stremio
        barrier
        flameshot
        spotify
        (blender.override { cudaSupport = true; } )
        gimp
        inkscape
        brave
        teams

        discord
        tdesktop
        whatsapp-for-linux

        osu-lazer
        
        (callPackage ./packages/arch-theme.pkg.nix { arch-theme = attrs.arch-theme; })
        (callPackage ./packages/papirus-icons.pkg.nix { papirus = attrs.papirus; })
        (callPackage ./packages/kwin-scripts.pkg.nix {})
        (callPackage ./packages/konsole-themes.pkg.nix {})
        (callPackage ./packages/firefox.pkg.nix { inherit attrs; })
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
          rssound = "systemctl --user restart pipewire";
          ls = "lsd";
          ca = "bat";
          da = "direnv allow";
        };
        functions = {
          gc = "git clone git@github.com:tnichols217/$argv";
          gacp = "git add -A && git commit -am $argv; git push";
          unpersist = "set TEMPFILE (mktemp); cp $argv $TEMPFILE; rm $argv; cp $TEMPFILE $argv; rm $TEMPFILE";
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
      ssh = {
        enable = true;
        matchBlocks = let 
          identityFile = "/home/${username}/.ssh/ed25519";
          user = "${username}";
          port = 27180;
        in {
          "MSI" = {
            hostname = "192.168.100.250";
            inherit user port identityFile;
          };
          "ASUS" = {
            hostname = "192.168.100.200";
            inherit user port identityFile;

          };
          "heyo" = {
            hostname = "heyo.ydns.eu";
            inherit user port identityFile;

          };
          "pigs" = {
            hostname = "pigsgo.mooo.com";
            inherit user port identityFile;
          };
          "gh" = {
            hostname = "github.com";
            user = "git";
            inherit identityFile;
          };
          "*" = {
            inherit identityFile;
          };
        };
      };
      vscode = import ./packages/vscode.nix ({ inherit pkgs vscodeExtensions attrs; });
      obs-studio = {
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
