{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.home-manager.url = github:nix-community/home-manager;
  inputs.nur.url = github:nix-community/NUR;
  inputs.omf.url = github:oh-my-fish/theme-bobthefish;
  inputs.arch-theme.url = github:rkstrdee/Arch;
  inputs.papirus.url = github:PapirusDevelopmentTeam/papirus-icon-theme;
  
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
  };
}