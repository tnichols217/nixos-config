{ pkgs, inputs, ... }:
pkgs.writeShellScriptBin "ani-cli-batch" (builtins.readFile "${inputs.ani-cli-batch}/ani-cli-batch")