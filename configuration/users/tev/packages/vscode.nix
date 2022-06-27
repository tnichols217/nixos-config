{ pkgs, ... }:

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
  extensions = [
    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      vsix = vscExt-alefragnani-project-manager;
    })
  ];
}