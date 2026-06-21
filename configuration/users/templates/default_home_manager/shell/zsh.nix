{
  pkgs,
  username,
  host-name,
  lib,
  inputs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        dirHashes = {
          docs = "$HOME/Documents";
          pr = "$HOME/Documents/projects";
          note = "$HOME/Documents/obsidian/notes";
        };
        history = {
          share = false;
        };
        initContent =
          let
            functions = {
              gc = "git clone git@github.com:tnichols217/$argv";
              gacp = "git add -A && git commit --allow-empty -am $argv; git push";
              unpersist = "TEMPFILE=$(mktemp); cp $argv $TEMPFILE; rm $argv; cp $TEMPFILE $argv; rm $TEMPFILE";
              gm = "CURBRANCH=$(git branch --show-current); git checkout $argv; git merge $CURBRANCH; git push; git checkout $CURBRANCH";
            };
          in
          builtins.concatStringsSep " " (
            (lib.attrsets.mapAttrsToList (name: value: "${name}() {${value}};") functions)
            ++ [
              ''bindkey "^[[1;5C" forward-word;''
              ''bindkey "^[[1;5D" backward-word;''
            ]
          );
        shellAliases = {
          clip = "tee >(xclip -selection clipboard -r) >(wl-copy) >/dev/null | echo";
          gac = "git add -A && git commit -am ";
          gp = "git push ";
          gpl = "git pull ";
          gs = "git submodule ";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          cdg = "cd $(git rev-parse --show-toplevel)";
          upg = "sudo ${pkgs.bash}/bin/bash -c \"cd /etc/nixos; ${pkgs.git}/bin/git stash; ${pkgs.git}/bin/git stash clear; ${pkgs.git}/bin/git pull; ${pkgs.nixos-rebuild-ng}/bin/nixos-rebuild switch --flake \\\".#${host-name}\\\" --refresh --log-format internal-json |& ${pkgs.nix-output-monitor}/bin/nom --json\"";
          sci = "ssh-copy-id -i ~/.ssh/ed25519 ";
          pathof = "path resolve ";
          c = "zeditor .";
          n = "nom";
          ls = "lsd";
          la = "lsd -lAgh";
          cat = "bat";
          da = "direnv allow";
          fsw = "fswatch -rax ";
          kitty = "${
            pkgs.callPackage ./kitty/kitty.pkg.nix {
              self = pkgs;
              inherit inputs;
            }
          }/bin/kitty";
          f = "xplr";
          cdf = "cd $(xplr)";
        };
      };
    };
  };
}
