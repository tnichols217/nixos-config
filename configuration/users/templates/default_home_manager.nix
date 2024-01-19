{ pkgs, attrs, username, host-name, version, lib, ... }:
{
  users.users.${username} = {
    shell = pkgs.zsh;
  };

  environment.pathsToLink = [ "/share/zsh" ];

  home-manager.backupFileExtension = "backup";

  nixpkgs.overlays = [
    (
      self: super: {
            kitty = import ./packages/kitty.pkg.nix { pkgs = super; inherit self; inherit attrs; };
          }
    )
  ];

  systemd.user.services."home-manager-dep-${username}" = {
    after = [ "systemd-tmpfiles-setup.service" ];
    before = [ "home-manager-${username}.service" ];
    script = "echo home-manager-${username} force dep on tmpfiles";
    description = "echo home-manager-${username} force dep on tmpfiles";
  };

  systemd.tmpfiles.rules = [
    "d /home/${username} 0700 ${username} users"
    "z /home/${username} 0700 ${username} users"
    "f /home/${username}/.local/state/nix/profiles/tmp/manifest.json 0755 ${username} users"
    "L /home/${username}/.local/state/nix/profiles/profile 0755 ${username} users - /home/${username}/.local/state/nix/profiles/tmp"
    "L /home/${username}/.local/state/nix/profiles/home-manager 0755 ${username} users - /home/${username}/.local/state/nix/profiles/tmp"
    "L /home/${username}/.nix-profile 0755 ${username} users - /home/${username}/.local/state/nix/profiles/profile"
    # "f /home/${username}/.nix-profile/manifest.json 0755 ${username} users"
  ];

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
        extraConfig = {
          credential = {
            helper = "store";
          };
        };
      };
      nix-index.enable = true;
      command-not-found.enable = pkgs.lib.mkForce false;
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
          upg = "sudo bash -c \"cd /etc/nixos; git stash; git stash clear; git pull; nixos-rebuild switch --flake \\\".#${host-name}\\\"\"";
          sci = "ssh-copy-id -i ~/.ssh/ed25519 ";
          pathof = "path resolve ";
          code = "codium";
          c = "codium .";
          rssound = "systemctl --user restart pipewire";
          ls = "lsd";
          ca = "bat";
          da = "direnv allow";
          fsw = "fswatch -rax ";
          black = "kill (pidof plasmashell); plasmashell &; disown (pidof plasmashell)";
        };
        functions = {
          gc = "git clone git@github.com:tnichols217/$argv";
          gacp = "git add -A && git commit --allow-empty -am $argv; git push";
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
      zsh = {
        initExtraBeforeCompInit = ''
          P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
          [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
        '';
        enable = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        # this line breaks my entire config for some reason
        # dotDir = ".config/zsh";
        dirHashes = {
          docs  = "$HOME/Documents";
          pr  = "$HOME/Documents/projects";
        };
        oh-my-zsh = {
          enable = true;
        };
        plugins = [
          {
            file = "powerlevel10k.zsh-theme";
            name = "powerlevel10k";
            src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
          }
          {
            file = "p10k.zsh";
            name = "powerlevel10k-config";
            src = ./zsh;
          }
        ];
        initExtra = let
        functions = {
          gc = "git clone git@github.com:tnichols217/$argv";
          gacp = "git add -A && git commit --allow-empty -am $argv; git push";
          unpersist = "TEMPFILE=$(mktemp); cp $argv $TEMPFILE; rm $argv; cp $TEMPFILE $argv; rm $TEMPFILE";
          gm = "CURBRANCH=$(git branch --show-current); git checkout $argv; git merge $CURBRANCH; git push; git checkout $CURBRANCH";
        };
        in builtins.concatStringsSep " " (lib.attrsets.mapAttrsToList (name: value: "${name}() {${value}};") functions) ;
        shellAliases = {
          clip = "xclip -selection clipboard -r";
          gac = "git add -A && git commit -am ";
          gp = "git push ";
          gpl = "git pull ";
          gs = "git submodule ";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          cdg = "cd $(git rev-parse --show-toplevel)";
          upg = "sudo bash -c \"cd /etc/nixos; git stash; git stash clear; git pull; nixos-rebuild switch --flake \\\".#${host-name}\\\"\"";
          sci = "ssh-copy-id -i ~/.ssh/ed25519 ";
          pathof = "path resolve ";
          code = "codium";
          c = "codium .";
          rssound = "systemctl --user restart pipewire";
          ls = "lsd";
          ca = "bat";
          da = "direnv allow";
          fsw = "fswatch -rax ";
          black = "kill (pidof plasmashell); plasmashell &; disown (pidof plasmashell)";
          kitty = "${pkgs.callPackage ./packages/kitty.pkg.nix { self = pkgs; inherit attrs; }}/bin/kitty";
        };
      };
      kitty = {
        enable = true;
        settings = {
          background_opacity = "0.5";
          background_blur = 5;
        };
      };
      fzf = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
      };
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
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
    services = {
      xsettingsd = {
        enable = true;
        settings = {
          "Gdk/UnscaledDPI" = if host-name == "ROG" then 147456 else 98304;
          "Gdk/WindowScalingFactor" = 1;
          "Gtk/EnableAnimations" = 1;
          "Gtk/DecorationLayout" = "icon:minimize,maximize,close";
          "Gtk/PrimaryButtonWarpsSlider" = 0;
          "Gtk/ToolbarStyle" = 3;
          "Gtk/MenuImages" = 1;
          "Gtk/ButtonImages" = 1;
          "Gtk/CursorThemeSize" = 24;
          "Gtk/CursorThemeName" = "breeze_cursors";
          "Net/IconThemeName" = "Papirus-Dark";
          "Gtk/FontName" = "Noto Sans,  10";
        };
      };
    };
  };
}
