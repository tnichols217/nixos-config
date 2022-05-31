{ config, pkgs, ... }:
{

  users.users.tev = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';
    shell = pkgs.fish;
  };

  home-manager.users.tev = {
    home = {
      stateVersion = "21.11";
      packages = with pkgs; [
        obsidian
        barrier
        gnupg
        oh-my-fish
        nur.repos.jomik.fishPlugins.theme-bobthefish
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
        extensions = with pkgs.vscode-extensions; [
          ms-toolsai.jupyter
          ms-python.python
          ms-python.pylance
          dotjoshjohnson.xml
          redhat.vscode-xml
          bbenoist.nix
          jnoortheen.nix-ide
        ];
        mutableExtensionsDir = false;
        userSettings = {
          "[nix]"."editor.tabSize" = 2;
          "editor.renderWhitespace" = "all";
          "editor.fontFamily" = "'Fira code', 'Hack', 'monospace', monospace";
          "editor.fontLigatures" = true;
          "editor.guides.bracketPairs" = true;
          "editor.bracketPairColorization.enabled" = true;
        };
      };
    };
  };
}
