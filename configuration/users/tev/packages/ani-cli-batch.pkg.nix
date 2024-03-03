{ pkgs, attrs, ... }:
pkgs.writeShellScriptBin "ani-cli-batch" (builtins.readFile "${attrs.ani-cli-batch}/ani-cli-batch")