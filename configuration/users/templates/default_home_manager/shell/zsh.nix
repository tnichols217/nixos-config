{ pkgs, attrs, username, host-name, version, lib, nix-index-database, ... }:
{
  home-manager.users.${username} = {
    programs = {
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
          la = "lsd -lAgh";
          cat = "bat";
          da = "direnv allow";
          fsw = "fswatch -rax ";
          black = "kill (pidof plasmashell); plasmashell &; disown (pidof plasmashell)";
          huion = "xsetwacom set `xinput | grep HUION | grep \"Pen stylus\" | head -1 | awk '{print $7;}' | cut -d \"=\" -f2` \"mapToOutput\" `xrandr | grep \" connected\" | grep \"Display\" | awk '{print $1;}'`";
          kitty = "${pkgs.callPackage ./kitty/kitty.pkg.nix { self = pkgs; inherit attrs; }}/bin/kitty";
        };
      };
    };
  };
}
