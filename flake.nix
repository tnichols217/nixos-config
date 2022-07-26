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

    # addons
    program-extensions = {
      url = "github:tnichols217/nixos-program-extensions";
      flake = false;
    };

    # firefox addons
    librewolfConfig = {
      url = "git+https://gitlab.com/librewolf-community/settings";
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
    version = "21.11";
    fullAttrs = { inherit attrs version; };
    in {
    nixosConfigurations.MSI = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = fullAttrs // { host-name = "MSI"; };
      modules = mods;
    };
    nixosConfigurations.ASUS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = fullAttrs // { host-name = "ASUS"; };
      modules = mods;
    };
  };
}