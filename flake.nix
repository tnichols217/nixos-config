{
  inputs = { 
    nixpkgs = {
      url = github:NixOS/nixpkgs/nixos-unstable;
    };
    home-manager = {
      url = github:nix-community/home-manager;
    };
    impermanence = {
      url = github:nix-community/impermanence;
    };
    nur = {
      url = github:nix-community/NUR;
    };
    btf = {
      url = github:oh-my-fish/theme-bobthefish;
      flake = false;
    };
    arch-theme = {
      url = github:rkstrdee/Arch;
      flake = false;
    };
    papirus = {
      url = github:PapirusDevelopmentTeam/papirus-icon-theme;
      flake = false;
    };
    chili = {
      url = github:MarianArlt/kde-plasma-chili;
      flake = false;
    };

    # firefox addons
    ublock = {
      url = "https://addons.mozilla.org/firefox/downloads/file/3961087/ublock_origin-1.43.0.xpi";
      flake = false;
    };
    dark-reader = {
      url = "https://addons.mozilla.org/firefox/downloads/file/3954503/darkreader-4.9.51.xpi";
      flake = false;
    };
    sponsorblock = {
      url = "https://addons.mozilla.org/firefox/downloads/file/3964892/sponsorblock-4.6.xpi";
      flake = false;
    };
    videospeed-controller = {
      url = "https://addons.mozilla.org/firefox/downloads/file/3756025/videospeed-0.6.3.3.xpi";
      flake = false;
    };
    tiled-tab-groups = {
      url = "https://addons.mozilla.org/firefox/downloads/file/3887846/tiled_tab_groups-0.18.25.xpi";
      flake = false;
    };
    dark-space-theme = {
      url = "https://addons.mozilla.org/firefox/downloads/file/3765900/nicothin_space-1.1.1.xpi";
      flake = false;
    };
    librewolfConfig = {
      url = "git+https://gitlab.com/librewolf-community/settings";
      flake = false;
    };

    # VScode extensions
    # Example link
    # "https://${publisher}.gallery.vsassets.io/_apis/public/gallery/publisher/${publisher}/extension/${name}/${version}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";

    vscExt-alefragnani-project-manager = {
        url = "https://alefragnani.gallery.vsassets.io/_apis/public/gallery/publisher/alefragnani/extension/project-manager/12.6.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-bbenoist-QML = {
        url = "https://bbenoist.gallery.vsassets.io/_apis/public/gallery/publisher/bbenoist/extension/QML/1.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-codezombiech-gitignore = {
        url = "https://codezombiech.gallery.vsassets.io/_apis/public/gallery/publisher/codezombiech/extension/gitignore/0.7.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-donjayamanne-git-extension-pack = {
        url = "https://donjayamanne.gallery.vsassets.io/_apis/public/gallery/publisher/donjayamanne/extension/git-extension-pack/0.1.3/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-donjayamanne-githistory = {
        url = "https://donjayamanne.gallery.vsassets.io/_apis/public/gallery/publisher/donjayamanne/extension/githistory/0.6.19/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-eamodio-gitlens = {
        url = "https://eamodio.gallery.vsassets.io/_apis/public/gallery/publisher/eamodio/extension/gitlens/12.1.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-mhutchie-git-graph = {
        url = "https://mhutchie.gallery.vsassets.io/_apis/public/gallery/publisher/mhutchie/extension/git-graph/1.30.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-qwtel-sqlite-viewer = {
        url = "https://qwtel.gallery.vsassets.io/_apis/public/gallery/publisher/qwtel/extension/sqlite-viewer/0.1.5/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-svelte-svelte-vscode = {
        url = "https://svelte.gallery.vsassets.io/_apis/public/gallery/publisher/svelte/extension/svelte-vscode/105.18.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-ziyasal-vscode-open-in-github = {
        url = "https://ziyasal.gallery.vsassets.io/_apis/public/gallery/publisher/ziyasal/extension/vscode-open-in-github/1.3.6/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-bbenoist-Nix = {
        url = "https://bbenoist.gallery.vsassets.io/_apis/public/gallery/publisher/bbenoist/extension/Nix/1.0.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-bierner-color-info = {
        url = "https://bierner.gallery.vsassets.io/_apis/public/gallery/publisher/bierner/extension/color-info/0.7.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-christian-kohler-path-intellisense = {
        url = "https://christian-kohler.gallery.vsassets.io/_apis/public/gallery/publisher/christian-kohler/extension/path-intellisense/2.8.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-cssho-vscode-svgviewer = {
        url = "https://cssho.gallery.vsassets.io/_apis/public/gallery/publisher/cssho/extension/vscode-svgviewer/2.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-ecmel-vscode-html-css = {
        url = "https://ecmel.gallery.vsassets.io/_apis/public/gallery/publisher/ecmel/extension/vscode-html-css/1.13.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-GrapeCity-gc-excelviewer = {
        url = "https://GrapeCity.gallery.vsassets.io/_apis/public/gallery/publisher/GrapeCity/extension/gc-excelviewer/4.2.55/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-jnoortheen-nix-ide = {
        url = "https://jnoortheen.gallery.vsassets.io/_apis/public/gallery/publisher/jnoortheen/extension/nix-ide/0.1.20/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-ms-python-python = {
        url = "https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/python/2022.8.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-ms-python-vscode-pylance = {
        url = "https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/vscode-pylance/2022.6.30/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-ms-toolsai-jupyter = {
        url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter/2022.4.1021342353/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-ms-toolsai-jupyter-keymap = {
        url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter-keymap/1.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-ms-toolsai-jupyter-renderers = {
        url = "https://ms-toolsai.gallery.vsassets.io/_apis/public/gallery/publisher/ms-toolsai/extension/jupyter-renderers/1.0.8/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-redhat-vscode-xml = {
        url = "https://redhat.gallery.vsassets.io/_apis/public/gallery/publisher/redhat/extension/vscode-xml/0.20.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-shd101wyy-markdown-preview-enhanced = {
        url = "https://shd101wyy.gallery.vsassets.io/_apis/public/gallery/publisher/shd101wyy/extension/markdown-preview-enhanced/0.6.3/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-TabNine-tabnine-vscode = {
        url = "https://TabNine.gallery.vsassets.io/_apis/public/gallery/publisher/TabNine/extension/tabnine-vscode/3.5.58/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-tht13-html-preview-vscode = {
        url = "https://tht13.gallery.vsassets.io/_apis/public/gallery/publisher/tht13/extension/html-preview-vscode/0.2.5/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-tht13-python = {
        url = "https://tht13.gallery.vsassets.io/_apis/public/gallery/publisher/tht13/extension/python/0.2.3/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-vscode-icons-team-vscode-icons = {
        url = "https://vscode-icons-team.gallery.vsassets.io/_apis/public/gallery/publisher/vscode-icons-team/extension/vscode-icons/11.12.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
    vscExt-yzane-markdown-pdf = {
        url = "https://yzane.gallery.vsassets.io/_apis/public/gallery/publisher/yzane/extension/markdown-pdf/1.4.4/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
        flake = false;
    };
  };
  
  outputs = { self, nixpkgs, ... }@attrs: let 
    mods = [
        attrs.home-manager.nixosModules.default
        attrs.impermanence.nixosModules.impermanence
        attrs.nur.nixosModules.nur
        ./configuration.nix
      ];
    vscodeExtensions = with attrs; { inherit
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
      ;
    };
    in {
    nixosConfigurations.MSI = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit attrs vscodeExtensions; host-name = "MSI"; };
      modules = mods;
    };
    nixosConfigurations.ASUS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit attrs vscodeExtensions; host-name = "ASUS"; };
      modules = mods;
    };
  };
}