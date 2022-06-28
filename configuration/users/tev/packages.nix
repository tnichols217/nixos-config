{ config, pkgs, username, attrs, host-name, vscode-exts,... }@a:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        obsidian
        barrier
        gnupg
        konsole
        flameshot
        ibus
        ibus-engines.uniemoji
        ibus-engines.libpinyin
        fswatch
        python3
        spotify
        libsForQt5.qt5.qttools
        # config.nur.repos.wolfangaukang.stremio
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
          upg = "sudo bash -c \"cd /etc/nixos; git pull; nixos-rebuild boot --flake \\\".#${host-name}\\\"\"";
        };
        plugins = [
          {
            name = "theme-bobthefish";
            src = attrs.btf;
          }
        ];
      };
      # firefox = {
      #   enable = true;
      #   # package = config.nur.repos.wolfangaukang.librewolf-bin;
      #   # extensions = with config.nur.repos.rycee.firefox-addons; [
      #   #   https-everywhere
      #   #   privacy-badger
      #   #   darkreader
      #   #   ublock-origin
      #   #   sponsorblock
      #   #   videospeed
      #   # ];
      # };
      fzf = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
      };
      gh = {
        enable = true;
        enableGitCredentialHelper = true;
      };
      vscode = import ./packages/vscode.nix (vscode-exts // { inherit pkgs; attrs = a; });
      obs-studio = {
        enable = true;
      };
    };
  };
}
