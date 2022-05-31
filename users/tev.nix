{ config, pkgs, ... }:
{

  users.users.tev = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';
  };

  home-manager.users.tev = {
    home = {
      stateVersion = "21.11";
      packages = with pkgs; [
        obsidian
        barrier
        gnupg
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
        extensions = [

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