{ pkgs, attrs, config, vscode_exts, openvsx_exts }:
{
  enable = true;
  # package = with vscode_exts; (pkgs.vscode-with-extensions.override {
  package = with pkgs.vscode-extensions; (pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = 
    # pkgs.lib.lists.forEach (builtins.attrNames (builtins.readDir (attrs.program-extensions.packages."x86_64-linux".default + "/vscode"))) (x: 
    #   let 
    #     vsix = attrs.program-extensions.packages."x86_64-linux".default + "/vscode/" + x;
    #     name = pkgs.lib.strings.splitString "." x;
    #   in
    #   pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    #     vsix = vsix;
    #     mktplcRef = {
    #       publisher = builtins.elemAt name 0;
    #       name = builtins.elemAt name 1;
    #       version = "latest";
    #     };
    #   }
    # ) ++ 
    [
      alefragnani.project-manager
      vscode_exts.bbenoist.qml
      codezombiech.gitignore
      vscode_exts.donjayamanne.git-extension-pack
      donjayamanne.githistory
      eamodio.gitlens
      mhutchie.git-graph
      vscode_exts.qwtel.sqlite-viewer
      svelte.svelte-vscode
      vscode_exts.ziyasal.vscode-open-in-github
      bbenoist.nix
      vscode_exts.bierner.color-info
      christian-kohler.path-intellisense
      ecmel.vscode-html-css
      grapecity.gc-excelviewer
      jnoortheen.nix-ide
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      redhat.vscode-xml
      tabnine.tabnine-vscode
      tht13.html-preview-vscode
      tht13.python
      vscode-icons-team.vscode-icons
      yzane.markdown-pdf
      aaron-bond.better-comments
      redhat.java
      aureliaeffect.aurelia
      msjsdiag.debugger-for-chrome
      steoates.autoimport
      editorconfig.editorconfig
      christian-kohler.path-intellisense
      behzad88.aurelia
      # ms-dotnettools.csharp
      openvsx_exts.muhammad-sammy.csharp
      redhat.vscode-yaml
      rust-lang.rust-analyzer
      orta.vscode-twoslash-queries
      paulober.pico-w-go
      firefox-devtools.vscode-firefox-debug
    ];
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
    "omnisharp.path" = "${pkgs.omnisharp-roslyn + "/bin/OmniSharp"}";
  };
}