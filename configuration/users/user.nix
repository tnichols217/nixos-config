{ username }:
  { config, pkgs, ... }:
  {
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
          # extensions = with pkgs; [
          #   vscode-extensions.ms-toolsai.jupyter
          #   vscode-extensions.ms-python.python
          #   vscode-extensions.ms-python.vscode-pylance
          #   vscode-extensions.dotjoshjohnson.xml
          #   vscode-extensions.redhat.vscode-yaml
          #   vscode-extensions.bbenoist.nix
          #   vscode-extensions.jnoortheen.nix-ide
          # ];
          # mutableExtensionsDir = false;
          userSettings = {
            "[nix]"."editor.tabSize" = 2;
            "editor.renderWhitespace" = "all";
            "editor.fontFamily" = "'Fira code', 'Hack', 'monospace', monospace";
            "editor.fontLigatures" = true;
            "editor.guides.bracketPairs" = true;
            "editor.bracketPairColorization.enabled" = true;
          };
        };
        obs-studio = {
          enable = true;
        };
      };
    };

    environment.persistence."/nix/persist/etc/nixos/configuration/persistence/data" = {
      hideMounts = false;
      users.${username} = {
        directories = [

          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "VirtualBox VMs"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          { directory = ".nixops"; mode = "0700"; }
          { directory = ".local/share/keyrings"; mode = "0700"; }
          ".local/share/direnv"

          ".config/gtk-3.0"   # fuse mounted to /home/$USERNAME/.config/gtk-3.0
          ".config/gtk-4.0"
          ".config/KDE"
          ".config/kde.org"
          ".config/plasma-workspace"
          ".config/xsettingsd"
          ".kde"

          ".local/share/baloo"
          ".local/share/dolphin"
          ".local/share/kactivitymanagerd"
          ".local/share/kate"
          ".local/share/klipper"
          ".local/share/konsole"
          ".local/share/kscreen"
          ".local/share/kwalletd"
          ".local/share/kxmlgui5"
          ".local/share/RecentDocuments"
          ".local/share/sddm"
        ];
        files = [
          ".screenrc"

          ".config/akregatorrc"
          ".config/baloofileinformationrc"
          ".config/baloofilerc"
          ".config/bluedevilglobalrc"
          ".config/device_automounter_kcmrc"
          ".config/dolphinrc"
          ".config/filetypesrc"
          ".config/gtkrc"
          ".config/gtkrc-2.0"
          ".config/gwenviewrc"
          ".config/kactivitymanagerd-pluginsrc"
          ".config/kactivitymanagerd-statsrc"
          ".config/kactivitymanagerd-switcher"
          ".config/kactivitymanagerdrc"
          ".config/katemetainfos"
          ".config/katerc"
          ".config/kateschemarc"
          ".config/katevirc"
          ".config/kcmfonts"
          ".config/kcminputrc"
          ".config/kconf_updaterc"
          ".config/kded5rc"
          ".config/kdeglobals"
          ".config/kgammarc"
          ".config/kglobalshortcutsrc"
          ".config/khotkeysrc"
          ".config/kmixrc"
          ".config/konsolerc"
          ".config/kscreenlockerrc"
          ".config/ksmserverrc"
          ".config/ksplashrc"
          ".config/ktimezonedrc"
          ".config/kwinrc"
          ".config/kwinrulesrc"
          ".config/kxkbrc"
          ".config/mimeapps.list"
          ".config/partitionmanagerrc"
          ".config/plasma-localerc"
          ".config/plasma-nm"
          ".config/plasma-org.kde.plasma.desktop-appletsrc"
          ".config/plasmanotifyrc"
          ".config/plasmarc"
          ".config/plasmashellrc"
          ".config/PlasmaUserFeedback"
          ".config/plasmawindowed-appletsrc"
          ".config/plasmawindowedrc"
          ".config/powermanagementprofilesrc"
          ".config/spectaclerc"
          ".config/startkderc"
          ".config/systemsettingsrc"
          ".config/Trolltech.conf"
          ".config/user-dirs.dirs"
          ".config/user-dirs.locale"

          ".local/share/krunnerstaterc"
          ".local/share/user-places.xbel"
          ".local/share/user-places.xbel.bak"
          ".local/share/user-places.xbel.tbcache"
        ];
      };
    };
  }