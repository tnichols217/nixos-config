{ username }:
{ config, pkgs, ... }:
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
        nur.repos.wolfangaukang.stremio
        spotify
        (callPackage ./arch-theme.pkg.nix {})
        (callPackage ./papirus-icons.pkg.nix {})
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
        };
        plugins = [
          {
            name = "theme-bobthefish";
            src = pkgs.fetchFromGitHub {
              owner = "oh-my-fish";
              repo = "theme-bobthefish";
              rev = "14a6f2b317661e959e13a23870cf89274f867f12";
              sha256 = "178wk0pz9vc6qn5c3my20yfr73s70kyd7zqf0xwr54q5l93rfplj";
            };
          }
        ];
      };
      firefox = {
        enable = true;
        # package = pkgs.nur.repos.wolfangaukang.librewolf-bin;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          https-everywhere
          privacy-badger
          darkreader
          ublock-origin
          sponsorblock
          videospeed
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
      vscode = {
        enable = true;
        package = pkgs.vscodium;
        userSettings = {
          "[nix]"."editor.tabSize" = 2;
          "editor.renderWhitespace" = "all";
          "editor.fontFamily" = "'Fira code', 'Hack', 'monospace', monospace";
          "editor.fontLigatures" = true;
          "editor.guides.bracketPairs" = true;
          "editor.bracketPairColorization.enabled" = true;
          "window.autoDetectColorScheme" = true;
          "editor.semanticHighlighting.enabled" = true;
          "workbench.colorTheme" = "Default Dark+";
        };
        # extensions = [
        #   (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        #     mktplcRef = {
        #       name = "nix-env-selector";
        #       publisher = "arrterian";
        #       version = "1.0.7";
        #       sha256 = "0e76885c9dbb6dca4eac8a75866ec372b948cc64a3a3845327d7c3ef6ba42a57";
        #     };
        #     meta = {
        #       license = lib.licenses.mit;
        #     };
        #   })
        # ];
      };
      obs-studio = {
        enable = true;
      };
    };
  };
}
