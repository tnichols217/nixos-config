{
  inputs = { 
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
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
  };
  
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit attrs; };
      modules = [
        attrs.home-manager.nixosModule
        attrs.impermanence.nixosModule
        attrs.nur.nixosModule
        # ./configuration.nix
      ];
    };
  };
}