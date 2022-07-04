{ pkgs, attrs, vscodeExtensions }:

{
  enable = true;
  package = pkgs.vscodium;
  userSettings = {
    "[nix]"."editor.tabSize" = 2;
    "editor.renderWhitespace" = "all";
    "editor.fontFamily" = "'Fira code', 'Hack', 'monospace', monospace";
    "editor.fontLigatures" = true;
    "editor.guides.bracketPairs" = true;
    "editor.bracketPairColorization.enabled" = true;
    "window.autoDetectColorScheme" = true;
    "editor.semanticHighlighting.enabled" = true;
    "workbench.colorTheme" = "Default Dark+";
  };
  mutableExtensionsDir = false;
  extensions = pkgs.lib.lists.forEach (builtins.attrNames (builtins.readDir (attrs.program-extensions + "/vscode/out"))) (x: 
    let 
      vsix = attrs.program-extensions + "/vscode/out/" + x;
      name = pkgs.lib.strings.splitString "." x;
    in
    pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      vsix = vsix;
      mktplcRef = {
        publisher = builtins.elemAt name 0;
        name = builtins.elemAt name 1;
        version = "latest";
      };
    }
  );
}