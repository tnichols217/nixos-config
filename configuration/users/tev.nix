args@{ config, pkgs, btf, arch-theme, papirus, 
  vscExt-alefragnani-project-manager,
  vscExt-bbenoist-QML,
  vscExt-codezombiech-gitignore,
  vscExt-donjayamanne-git-extension-pack,
  vscExt-donjayamanne-githistory,
  vscExt-eamodio-gitlens,
  vscExt-mhutchie-git-graph,
  vscExt-qwtel-sqlite-viewer,
  vscExt-svelte-svelte-vscode,
  vscExt-ziyasal-vscode-open-in-github,
  vscExt-bbenoist-Nix,
  vscExt-bierner-color-info,
  vscExt-christian-kohler-path-intellisense,
  vscExt-cssho-vscode-svgviewer,
  vscExt-ecmel-vscode-html-css,
  vscExt-GrapeCity-gc-excelviewer,
  vscExt-jnoortheen-nix-ide,
  vscExt-ms-python-python,
  vscExt-ms-python-vscode-pylance,
  vscExt-ms-toolsai-jupyter,
  vscExt-ms-toolsai-jupyter-keymap,
  vscExt-ms-toolsai-jupyter-renderers,
  vscExt-redhat-vscode-xml,
  vscExt-shd101wyy-markdown-preview-enhanced,
  vscExt-TabNine-tabnine-vscode,
  vscExt-tht13-html-preview-vscode,
  vscExt-tht13-python,
  vscExt-vscode-icons-team-vscode-icons,
  vscExt-yzane-markdown-pdf, ... }:
let
  username = "tev";
  vscode-exts = [
    vscExt-alefragnani-project-manager
    vscExt-bbenoist-QML
    vscExt-codezombiech-gitignore
    vscExt-donjayamanne-git-extension-pack
    vscExt-donjayamanne-githistory
    vscExt-eamodio-gitlens
    vscExt-mhutchie-git-graph
    vscExt-qwtel-sqlite-viewer
    vscExt-svelte-svelte-vscode
    vscExt-ziyasal-vscode-open-in-github
    vscExt-bbenoist-Nix
    vscExt-bierner-color-info
    vscExt-christian-kohler-path-intellisense
    vscExt-cssho-vscode-svgviewer
    vscExt-ecmel-vscode-html-css
    vscExt-GrapeCity-gc-excelviewer
    vscExt-jnoortheen-nix-ide
    vscExt-ms-python-python
    vscExt-ms-python-vscode-pylance
    vscExt-ms-toolsai-jupyter
    vscExt-ms-toolsai-jupyter-keymap
    vscExt-ms-toolsai-jupyter-renderers
    vscExt-redhat-vscode-xml
    vscExt-shd101wyy-markdown-preview-enhanced
    vscExt-TabNine-tabnine-vscode
    vscExt-tht13-html-preview-vscode
    vscExt-tht13-python
    vscExt-vscode-icons-team-vscode-icons
    vscExt-yzane-markdown-pdf
  ];
in
{
  imports =
  [
    ((import ./templates/persist.nix) (args // { inherit username; }))
    ((import ./tev/config.nix) (args // { inherit username; }))
    ((import ./tev/packages.nix) (args // { inherit username arch-theme papirus vscode-exts; }))
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = ''$6$HeYdqp57.G0nM9K/$.i5eB/rANAYEeGYLxdvbM8jklRy3UebqHsWoHMabC5yQaUoaday9xhbCS7CVF9jANq0isTJK8US7C5/WNmPP7.'';
    shell = pkgs.fish;
  };

  home-manager.users.${username} = {
    home = {
      stateVersion = "21.11";
    };
    gtk = {
      enable = true;
    };
  };
}
