{ pkgs, vscodeExtensions }:

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
  extensions = let 
    mappedVscodeExtensions = builtins.mapAttrs (name: value: (import ./vscode/parseVSIXfile.nix { inherit pkgs; file = value; })) vscodeExtensions;
    # mappedVscodeExtensions = builtins.map (x : x) vscodeExtensions;
  in builtins.map pkgs.vscode-utils.buildVscodeMarketplaceExtension [
    (let 
      publisher = "alefragnani";
      name = "project-manager";
    in {
      vsix = mappedVscodeExtensions."${"vscExt-" + publisher + "-" + name}";
      mktplcRef = {
        inherit publisher name;
        version = "12.6.0";
      };
    })
    # {
    #   vsix = mappedVscodeExtensions.vscExt-bbenoist-QML;
    #   mktplcRef = {
    #     publisher = "bbenoist";
    #     name = "QML";
    #     version = "1.0.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-codezombiech-gitignore;
    #   mktplcRef = {
    #     publisher = "codezombiech";
    #     name = "gitignore";
    #     version = "0.7.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-donjayamanne-git-extension-pack;
    #   mktplcRef = {
    #     publisher = "donjayamanne";
    #     name = "git-extension-pack";
    #     version = "0.1.3";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-donjayamanne-githistory;
    #   mktplcRef = {
    #     publisher = "donjayamanne";
    #     name = "githistory";
    #     version = "0.6.19";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-eamodio-gitlens;
    #   mktplcRef = {
    #     publisher = "eamodio";
    #     name = "gitlens";
    #     version = "12.1.1";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-mhutchie-git-graph;
    #   mktplcRef = {
    #     publisher = "mhutchie";
    #     name = "git-graph";
    #     version = "1.30.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-qwtel-sqlite-viewer;
    #   mktplcRef = {
    #     publisher = "qwtel";
    #     name = "sqlite-viewer";
    #     version = "0.1.5";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-svelte-svelte-vscode;
    #   mktplcRef = {
    #     publisher = "svelte";
    #     name = "svelte-vscode";
    #     version = "105.18.1";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-ziyasal-vscode-open-in-github;
    #   mktplcRef = {
    #     publisher = "ziyasal";
    #     name = "vscode-open-in-github";
    #     version = "1.3.6";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-bbenoist-Nix;
    #   mktplcRef = {
    #     publisher = "bbenoist";
    #     name = "Nix";
    #     version = "1.0.1";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-bierner-color-info;
    #   mktplcRef = {
    #     publisher = "bierner";
    #     name = "color-info";
    #     version = "0.7.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-christian-kohler-path-intellisense;
    #   mktplcRef = {
    #     publisher = "christian-kohler";
    #     name = "path-intellisense";
    #     version = "2.8.1";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-cssho-vscode-svgviewer;
    #   mktplcRef = {
    #     publisher = "cssho";
    #     name = "vscode-svgviewer";
    #     version = "2.0.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-ecmel-vscode-html-css;
    #   mktplcRef = {
    #     publisher = "ecmel";
    #     name = "vscode-html-css";
    #     version = "1.13.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-GrapeCity-gc-excelviewer;
    #   mktplcRef = {
    #     publisher = "GrapeCity";
    #     name = "gc-excelviewer";
    #     version = "4.2.55";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-jnoortheen-nix-ide;
    #   mktplcRef = {
    #     publisher = "jnoortheen";
    #     name = "nix-ide";
    #     version = "0.1.20";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-ms-python-python;
    #   mktplcRef = {
    #     publisher = "ms-python";
    #     name = "python";
    #     version = "2022.8.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-ms-python-vscode-pylance;
    #   mktplcRef = {
    #     publisher = "ms-python";
    #     name = "vscode-pylance";
    #     version = "2022.6.30";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-ms-toolsai-jupyter;
    #   mktplcRef = {
    #     publisher = "ms-toolsai";
    #     name = "jupyter";
    #     version = "2022.4.1021342353";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-ms-toolsai-jupyter-keymap;
    #   mktplcRef = {
    #     publisher = "ms-toolsai";
    #     name = "jupyter-keymap";
    #     version = "1.0.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-ms-toolsai-jupyter-renderers;
    #   mktplcRef = {
    #     publisher = "ms-toolsai";
    #     name = "jupyter-renderers";
    #     version = "1.0.8";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-redhat-vscode-xml;
    #   mktplcRef = {
    #     publisher = "redhat";
    #     name = "vscode-xml";
    #     version = "0.20.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-shd101wyy-markdown-preview-enhanced;
    #   mktplcRef = {
    #     publisher = "shd101wyy";
    #     name = "markdown-preview-enhanced";
    #     version = "0.6.3";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-TabNine-tabnine-vscode;
    #   mktplcRef = {
    #     publisher = "TabNine";
    #     name = "tabnine-vscode";
    #     version = "3.5.58";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-tht13-html-preview-vscode;
    #   mktplcRef = {
    #     publisher = "tht13";
    #     name = "html-preview-vscode";
    #     version = "0.2.5";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-tht13-python;
    #   mktplcRef = {
    #     publisher = "tht13";
    #     name = "python";
    #     version = "0.2.3";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-vscode-icons-team-vscode-icons;
    #   mktplcRef = {
    #     publisher = "vscode-icons-team";
    #     name = "vscode-icons";
    #     version = "11.12.0";
    #   };
    # }
    # {
    #   vsix = mappedVscodeExtensions.vscExt-yzane-markdown-pdf;
    #   mktplcRef = {
    #     publisher = "yzane";
    #     name = "markdown-pdf";
    #     version = "1.4.4";
    #   };
    # }
  ];
}