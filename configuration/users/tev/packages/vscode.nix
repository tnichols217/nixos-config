{ pkgs, config, vscode_exts, openvsx_exts, ... }:
{
  enable = true;
  package = pkgs.vscodium;
  profiles = {
    default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = [
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
        vscode_exts.ecmel.vscode-html-css
        grapecity.gc-excelviewer
        jnoortheen.nix-ide
        (openvsx_exts.ms-python.python.overrideAttrs (final: prev: (prev // {
          buildPhase = prev.buildPhase + ''
            pkg=package.json
            cat $pkg | ${pkgs.jq}/bin/jq ".engines.vscode=\"^1.92.0\"" > $pkg.new
            rm $pkg
            mv $pkg.new $pkg
          '';
        })))
        openvsx_exts.detachhead.basedpyright
        # ms-python.vscode-pylance
        mshr-h.veriloghdl
        redhat.vscode-xml
        tabnine.tabnine-vscode
        vscode_exts.tht13.html-preview-vscode
        vscode-icons-team.vscode-icons
        vscode_exts.yzane.markdown-pdf
        vscode_exts.aaron-bond.better-comments
        redhat.java
        vscode_exts.aureliaeffect.aurelia
        vscode_exts.msjsdiag.debugger-for-chrome
        vscode_exts.steoates.autoimport
        editorconfig.editorconfig
        christian-kohler.path-intellisense
        vscode_exts.behzad88.aurelia
        # ms-dotnettools.csharp
        openvsx_exts.muhammad-sammy.csharp
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        vscode_exts.orta.vscode-twoslash-queries
        vscode_exts.paulober.pico-w-go
        firefox-devtools.vscode-firefox-debug
        vscode_exts.vscjava.vscode-java-test
        vscode_exts.vscjava.vscode-java-debug
        vscode_exts.vscjava.vscode-maven
        openvsx_exts.genuitecllc.codetogether
        (openvsx_exts.ms-toolsai.jupyter.overrideAttrs (final: prev: (prev // {
          buildPhase = prev.buildPhase + ''
            pkg=package.json
            cat $pkg | ${pkgs.jq}/bin/jq ".engines.vscode=\"^1.92.0\"" > $pkg.new
            rm $pkg
            mv $pkg.new $pkg
          '';
        })))
        openvsx_exts.ms-toolsai.vscode-jupyter-cell-tags
        openvsx_exts.ms-toolsai.vscode-jupyter-slideshow
        openvsx_exts.quarto.quarto
        openvsx_exts.reditorsupport.r
        openvsx_exts.julialang.language-julia
        openvsx_exts.charliermarsh.ruff
        openvsx_exts.labring.open-remote-ssh-for-trae
        # openvsx_exts.tamasfe.even-better-toml
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-python.vscode-pylance
        vscode_exts.ms-mssql.mssql
        vscode_exts.mathworks.language-matlab
        pkgs.vscode-extensions."13xforever".language-x86-64-assembly
        pkgs.vscode-extensions.uiua-lang.uiua-vscode
        mkhl.direnv
        openvsx_exts.dbaeumer.vscode-eslint
        openvsx_exts.jeanp413.open-remote-ssh
        openvsx_exts.ms-vscode.js-debug
      ];
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
        "editor.tokenColorCustomizations" = {
          "textMateRules"= [
            {
              "scope" = "meta.function-call.generic.python";
              "settings" = {
                "foreground" = "#dcdcaa";
              };
            }
          ];
        };
        "tabnine.experimentalAutoImports" = true;
        "java.inlayHints.parameterNames.enabled" = "all";
        "git.autofetch" = true;
        "omnisharp.path" = "${pkgs.omnisharp-roslyn + "/bin/OmniSharp"}";
        "terminal.integrated.commandsToSkipShell" = [
          "matlab.interrupt"
        ];
        "window.customTitleBarVisibility" = "never";
        "r.rpath.linux" = "R";
        "r.rterm.linux" = "radian";
        "r.lsp.promptToInstall" = false;
      };
    };
  };
}
