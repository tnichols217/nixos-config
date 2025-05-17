{ pkgs, config, vscode_exts, openvsx_exts, ... }:
{
  enable = true;
  package = pkgs.vscodium;
  profiles = {
    default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with openvsx_exts; [
        alefragnani.project-manager
        vscode_exts.bbenoist.qml
        codezombiech.gitignore
        vscode_exts.donjayamanne.git-extension-pack
        donjayamanne.githistory
        eamodio.gitlens
        qwtel.sqlite-viewer
        svelte.svelte-vscode
        bbenoist.nix
        bierner.color-info
        christian-kohler.path-intellisense
        ecmel.vscode-html-css
        grapecity.gc-excelviewer
        jnoortheen.nix-ide
        (ms-python.python.overrideAttrs (final: prev: (prev // {
          buildPhase = prev.buildPhase + ''
            pkg=package.json
            cat $pkg | ${pkgs.jq}/bin/jq ".engines.vscode=\"^1.92.0\"" > $pkg.new
            rm $pkg
            mv $pkg.new $pkg
          '';
        })))
        detachhead.basedpyright
        mshr-h.veriloghdl
        redhat.vscode-xml
        tabnine.tabnine-vscode
        vscode-icons-team.vscode-icons
        aaron-bond.better-comments
        redhat.java
        vscode_exts.aureliaeffect.aurelia
        steoates.autoimport
        editorconfig.editorconfig
        christian-kohler.path-intellisense
        vscode_exts.behzad88.aurelia
        # ms-dotnettools.csharp
        muhammad-sammy.csharp
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        orta.vscode-twoslash-queries
        paulober.pico-w-go
        firefox-devtools.vscode-firefox-debug
        vscjava.vscode-java-test
        vscjava.vscode-java-debug
        vscjava.vscode-maven
        genuitecllc.codetogether
        (ms-toolsai.jupyter.overrideAttrs (final: prev: (prev // {
          buildPhase = prev.buildPhase + ''
            pkg=package.json
            cat $pkg | ${pkgs.jq}/bin/jq ".engines.vscode=\"^1.92.0\"" > $pkg.new
            rm $pkg
            mv $pkg.new $pkg
          '';
        })))
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        quarto.quarto
        reditorsupport.r
        julialang.language-julia
        charliermarsh.ruff
        labring.open-remote-ssh-for-trae
        # tamasfe.even-better-toml
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-mssql.mssql
        vscode_exts.mathworks.language-matlab
        jeff-hykin.better-m-syntax
        pkgs.vscode-extensions."13xforever".language-x86-64-assembly
        pkgs.vscode-extensions.uiua-lang.uiua-vscode
        mkhl.direnv
        dbaeumer.vscode-eslint
        jeanp413.open-remote-ssh
        ms-vscode.js-debug
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
