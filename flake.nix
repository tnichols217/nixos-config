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
    librewolfConfig = {
      url = "https://gitlab.com/librewolf-community/settings/-/raw/master/librewolf.cfg";
      flake = false;
    };
  };
  
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit attrs; };
      modules = [
        attrs.home-manager.nixosModules.default
        attrs.impermanence.nixosModules.impermanence
        attrs.nur.nixosModules.nur
        ./configuration.nix
      ];
    };
  };
}