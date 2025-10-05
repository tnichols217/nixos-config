{ pkgs, username, host-name, version, lib, nix-index-database, inputs, ... }:
{
  home-manager.users.${username} = {
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        dirHashes = {
          docs  = "$HOME/Documents";
          pr  = "$HOME/Documents/projects";
          note = "$HOME/Documents/obsidian/notes";
        };
        history = {
          share = false;
        };
        initContent = let
        functions = {
          gc = "git clone git@github.com:tnichols217/$argv";
          gacp = "git add -A && git commit --allow-empty -am $argv; git push";
          unpersist = "TEMPFILE=$(mktemp); cp $argv $TEMPFILE; rm $argv; cp $TEMPFILE $argv; rm $TEMPFILE";
          gm = "CURBRANCH=$(git branch --show-current); git checkout $argv; git merge $CURBRANCH; git push; git checkout $CURBRANCH";
        };
        in builtins.concatStringsSep " " ((lib.attrsets.mapAttrsToList (name: value: "${name}() {${value}};") functions) ++ [
          ''bindkey "^[[1;5C" forward-word;''
          ''bindkey "^[[1;5D" backward-word;''
        ]) ;
        shellAliases = {
          clip = "tee >(xclip -selection clipboard -r) >(wl-copy) >/dev/null | echo";
          gac = "git add -A && git commit -am ";
          gp = "git push ";
          gpl = "git pull ";
          gs = "git submodule ";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          cdg = "cd $(git rev-parse --show-toplevel)";
          upg = "sudo bash -c \"cd /etc/nixos; git stash; git stash clear; git pull; nixos-rebuild switch --flake \\\".#${host-name}\\\" $argv\"";
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
          huion = "xsetwacom set `xinput | grep HUION | grep \"Pen stylus\" | head -1 | awk '{print $7;}' | cut -d \"=\" -f2` \"mapToOutput\" `xrandr | grep \" connected\" | grep \"Display\" | awk '{print $1;}'`; xsetwacom set `xinput | grep HUION | grep \"stylus\" | tac | head -1 | awk '{print $7;}' | cut -d \"=\" -f2` \"mapToOutput\" `xrandr | grep \" connected\" | grep \"Display\" | awk '{print $1;}'`";
          kitty = "${pkgs.callPackage ./kitty/kitty.pkg.nix { self = pkgs; inherit inputs; }}/bin/kitty";
          logout = "qdbus org.kde.LogoutPrompt /LogoutPrompt org.kde.LogoutPrompt.promptLogout";
          f = "xplr";
          cdf = "cd $(xplr)";
        };
      };
    };
  };
}
