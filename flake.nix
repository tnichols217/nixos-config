{
  inputs = {
    nixpkgs = {
      url = github:NixOS/nixpkgs/nixos-unstable;
    };
    nixpkgs_old = {
      url = github:NixOS/nixpkgs/nixos-22.11;
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = github:nix-community/impermanence;
    };
    nur = {
      url = github:nix-community/NUR;
    };
    arion = {
      url = github:hercules-ci/arion;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minecraft-arion = {
      url = "github:tnichols217/nix-minecraft-server";
      inputs.nixpkgs.follows = "nixpkgs";
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
    p10k = {
      url = github:romkatv/powerlevel10k;
      flake = false;
    };
    # kitty themes
    kitty-themes = {
      url = github:dexpota/kitty-themes;
      flake = false;
    };

    # addons
    program-extensions = {
      url = "github:tnichols217/nixos-program-extensions";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    # firefox addons
    librewolfConfig = {
      url = "git+https://gitlab.com/librewolf-community/settings.git/";
      flake = false;
    };

    # nix-index
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, nixos-generators, nix-index-database, nixpkgs_old, nix-vscode-extensions, arion, minecraft-arion, flake-utils, ... }@attrs: let 
      mods = [
          attrs.home-manager.nixosModules.default
          attrs.impermanence.nixosModules.impermanence
          attrs.nur.nixosModules.nur
          # nix-index-database.nixosModules.nix-index
          ./configuration.nix
        ];
      version = "23.05";
      fullAttrs = {
        inherit attrs version;
        oldpkgs = import nixpkgs_old { system = "x86_64-linux"; config = {allowUnfree = true;};};
        vscode_exts = attrs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace;
        openvsx_exts = attrs.nix-vscode-extensions.extensions.x86_64-linux.open-vsx;
      };
    in {
    nixosConfigurations = {
      MSI = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = fullAttrs // { host-name = "MSI"; };
        modules = mods;
      };
      ROG = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = fullAttrs // { host-name = "ROG"; };
        modules = mods;
      };
      ASUS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = fullAttrs // { host-name = "ASUS"; };
        modules = mods ++ [ arion.nixosModules.arion ];
      };
    };
    packages.x86_64-linux = rec {
      iso = nixos-generators.nixosGenerate {
        specialArgs = fullAttrs // { host-name = "MSI"; };
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = mods;
        format = "iso";
      };
      default = iso;
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    {
      apps = rec {
        test = {
          type = "app";
          program = ./nix/scripts/test.sh;
        };
        build = {
          type = "app";
          program = ./nix/scripts/build.sh;
        };
        default = build;
      };
    }
  );
}