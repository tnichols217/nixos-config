{ config, pkgs, username, attrs, host-name, vscodeExtensions,... }:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # utils
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
        nodePackages.npm
        jre8
        virt-manager

        # programs
        filezilla
        filelight
        libreoffice
        lolcat
        htop

        obsidian
        config.nur.repos.wolfangaukang.stremio
        barrier
        flameshot
        spotify
        blender
        gimp
        inkscape
        brave

        discord
        tdesktop
        whatsapp-for-linux
        
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
      };
      fish = {
        enable = true;
        shellAliases = {
          clip = "xclip -selection clipboard -r";
          gac = "git add -A && git commit -am ";
          gp = "git push ";
          gpl = "git pull ";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          cdg = "cd $(git rev-parse --show-toplevel)";
          upt  = "cd /etc/nixos; sudo nix flake update";
          upg = "sudo bash -c \"cd /etc/nixos; git pull; nixos-rebuild boot --flake \\\".#${host-name}\\\"\"";
          uptg = "upt; upg";
          sci = "ssh-copy-id -i ~/.ssh/ed25519 ";
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
      };
      ssh = {
        enable = true;
        matchBlocks = {
          "MSI" = {
            hostname = "192.168.100.250";
            user = "${username}";
            port = 27180;
          };
          "Desktop" = {
            hostname = "192.168.100.200";
            user = "${username}";
            port = 27180;
          };
          "heyo" = {
            hostname = "heyo.ydns.eu";
            user = "${username}";
            port = 27180;
          };
        };
      };
      vscode = import ./packages/vscode.nix ({ inherit pkgs vscodeExtensions attrs; });
      obs-studio = {
        enable = true;
      };
    };
  };
}
