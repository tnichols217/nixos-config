{ pkgs, attrs }:

{
  enable = true;
  package = (pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = pkgs.lib.lists.forEach (builtins.attrNames (builtins.readDir (attrs.program-extensions.packages."x86_64-linux".default + "/vscode"))) (x: 
      let 
        vsix = attrs.program-extensions.packages."x86_64-linux".default + "/vscode/" + x;
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
  }) // { pname = "vscodium"; };
  userSettings = {
    "[nix]"."editor.tabSize" = 2;
    "editor.renderWhitespace" = "all";
    "editor.fontFamily" = "'FiraCode Nerd Font', 'Hack', 'monospace', monospace";
    "editor.fontLigatures" = true;
    "editor.guides.bracketPairs" = true;
    "editor.bracketPairColorization.enabled" = true;
    "editor.semanticHighlighting.enabled" = true;
    "workbench.colorTheme" = "Default Dark+";
    "workbench.iconTheme" = "vscode-icons";
    "tabnine.experimentalAutoImports" = true;
    "java.inlayHints.parameterNames.enabled" = "all";
    "git.autofetch" = true;
  };
}