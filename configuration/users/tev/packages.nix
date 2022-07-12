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
        bat
        xclip

        # programs
        filezilla
        filelight
        libreoffice
        davinci-resolve
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
        functions = {
          gc = "git clone git@github.com:tnichols217/$argv";
          gacp = "git add -A && git commit -am $argv; git push";
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
          "Desktop" = {
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
    };
  };
}
