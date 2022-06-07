{ config, pkgs, ... }:
let
  username = "tev";
in
{
  imports =
  [
    ((import ./templates/persist.nix) { username = "${username}"; })
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';
    shell = pkgs.fish;
  };

  home-manager.users.${username} = {
    home = {
      stateVersion = "21.11";
      packages = with pkgs; [
        obsidian
        barrier
        gnupg
        # oh-my-fish
        # nur.repos.jomik.fishPlugins.theme-bobthefish
        konsole
        flameshot
        fswatch
        arc-kde-theme
        python
        import ./tev/arch-theme.nix
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
        };
      };
      obs-studio = {
        enable = true;
      };
    };
    gtk = {
      enable = true;

    };
  };
}
