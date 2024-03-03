{ pkgs, attrs, ... }:
pkgs.writeShellScriptBin (builtins.readFile "${attrs.ani-cli-batch}/ani-cli-batch")