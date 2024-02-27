{ pkgs, attrs, username, host-name, version, lib, nix-index-database, ... }:
{
  home-manager.users.${username} = {
    programs = {
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
          cat = "bat";
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
    };
  };
}
