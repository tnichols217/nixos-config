{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    # nixpkgs_old = {
    #   url = github:NixOS/nixpkgs/nixos-22.11;
    # };
    home-manager = {
      # url = github:nix-community/home-manager;
      # Until home-manager merges my diff maybe
      url = "github:tnichols217/home-manager/forceFlakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zlong_alert = {
      url = "github:kevinywlui/zlong_alert.zsh";
      flake = false;
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };
    arion = {
      url = "github:hercules-ci/arion";
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
      url = "github:oh-my-fish/theme-bobthefish";
      flake = false;
    };
    arch-theme = {
      url = "github:rkstrdee/Arch";
      flake = false;
    };
    papirus = {
      url = "github:PapirusDevelopmentTeam/papirus-icon-theme";
      flake = false;
    };
    chili = {
      url = "github:MarianArlt/kde-plasma-chili";
      flake = false;
    };
    p10k = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };
    ani-cli-batch = {
      url = "github:75rx/ani-cli-batch";
      flake = false;
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
    };

    # kitty themes
    kitty-themes = {
      url = "github:dexpota/kitty-themes";
      flake = false;
    };

    # addons
    firefox-extensions = {
      url = "github:OsiPog/nix-firefox-addons";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox addons
    librewolfConfig = {
      url = "git+https://gitlab.com/librewolf-community/settings.git/";
      flake = false;
    };

    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
    
    nix-ld.url = "github:Mic92/nix-ld";

    hy3 = {
      url = "github:outfoxxed/hy3";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, ... }@inputs: let 
    pre-mods = [
      # inputs.nixpkgs.nixosModules.readOnlyPkgs
      inputs.home-manager.nixosModules.default
      inputs.impermanence.nixosModules.impermanence
      inputs.nixos-generators.nixosModules.all-formats
      # inputs.nixvim.homeManagerModules.nixvim
      # inputs.nix-ld.nixosModules.nix-ld
      # nix-index-database.nixosModules.nix-index
    ];
    mods = pre-mods ++ [
      ./configuration.nix
    ];
    version = "24.05";
    config = {
      allowUnfree = true;
      # TODO until obsidian updates electron
      # TODO until sonarr fixes dep
      permittedInsecurePackages = [
        "electron-25.9.0"
        "aspnetcore-runtime-6.0.36"
        "aspnetcore-runtime-wrapped-6.0.36"
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-wrapped-6.0.428"
      ];
    };
    addresses = rec {
      pigs = "pigsgo.mooo.com";
      heyo = "heyo.ydns.eu";
      square = "pigsgomoo.com";
      asus = "tln32asus.student.cwru.edu";
      rog = "tln32rog.student.cwru.edu";
      msi = "tln32msi.student.cwru.edu";
      default = square;

      serve = "serve.${addresses.default}";
      nextcloud = "nextcloud.${addresses.default}";
      lidarr = "lidarr.${addresses.default}";
      radarr = "radarr.${addresses.default}";
      sonarr = "sonarr.${addresses.default}";
      readarr = "readarr.${addresses.default}";
      prowlarr = "prowlarr.${addresses.default}";
      jellyfin = "jellyfin.${addresses.default}";
      qbittorrent = "qbit.${addresses.default}";
      authelia = "auth.${addresses.default}";
      home-assistant = "hath.${addresses.default}";
    };
    ports = {
      ssh = 2200;
      serve = 5000;
      nextcloud = 443;
      lidarr = 8686;
      radarr = 7878;
      sonarr = 8989;
      readarr = 8787;
      prowlarr = 9696;
      transmission = 9091;
      qbitfe = 9090;
      qbittorrent = 9009;
      jellyfin = 8096;
      authelia = 9191;
      rkvm = 5258;
      home-assistant = 8123;
    };
    addressNumbers = {
      lidarr = "10";
      radarr = "11";
      sonarr = "12";
      readarr = "13";
      transmission = "14";
      jellyfin = "15";
      prowlarr = "16";
    };
    persistence = rec {
      default = "/nix/persist";
      local = "${default}/local";
      data = "${default}/data";
      bucket = "${default}/bucket";
      media = "${default}/media";
    };
    outs = inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      fullAttrs = {
        inherit inputs version addresses persistence ports addressNumbers;
        vscode_exts = inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace;
        openvsx_exts = inputs.nix-vscode-extensions.extensions.${system}.open-vsx;
        nix-index-database = inputs.nix-index-database.packages.${system};
        host-name = "ROG";
        is-iso = false;
      };
    in rec {
      nixosConfigurations = let
      configs = {p, sys}: let
        fullAttrsPkgs = fullAttrs // { pkgs = p; };
      in {
        MSI = inputs.nixpkgs.lib.nixosSystem {
          system = sys;
          specialArgs = fullAttrsPkgs // { host-name = "MSI"; };
          modules = mods;
        };
        ROG = inputs.nixpkgs.lib.nixosSystem {
          system = sys;
          specialArgs = fullAttrsPkgs;
          modules = mods;
        };
        ASUS = inputs.nixpkgs.lib.nixosSystem {
          system = sys;
          specialArgs = fullAttrsPkgs // { host-name = "ASUS"; };
          modules = mods ++ [ inputs.arion.nixosModules.arion ];
        };
        linode = inputs.nixpkgs.lib.nixosSystem {
          system = sys;
          specialArgs = fullAttrsPkgs // { host-name = "linode"; };
          modules = [ ./linode.nix ];
        };
        rpi = inputs.nixpkgs.lib.nixosSystem {
          system = sys;
          specialArgs = fullAttrs // { host-name = "rpi"; };
          modules = pre-mods ++ [
            # inputs.raspberry-pi-nix.nixosModules.raspberry-pi
            # inputs.raspberry-pi-nix.nixosModules.sd-image
            inputs.disko.nixosModules.disko
            ./rpi.nix
          ];
        };
      };
      in (configs { p = (import inputs.nixpkgs { inherit system config;}); sys = system; }) //
      { cross = (inputs.flake-utils.lib.eachDefaultSystem (sys:
          (configs { p = (import inputs.nixpkgs { inherit config; localSystem = system; crossSystem = sys; }); inherit sys;})
        ));
      };
      packages = 
      let 
        isoargs = {
          specialArgs = fullAttrs // { is-iso = true; };
          modules = mods;
          format = "iso";
        };
        sdargs = {
          specialArgs = fullAttrs // { is-iso = true; };
          modules = mods;
          format = "sd-aarch64-installer";
        };
        linodeargs = {
          specialArgs = fullAttrs // { host-name = "linode"; };
          modules = [ ./linode.nix ];
          format = "linode";
        };
        # rpiargs = {
        #   specialArgs = fullAttrs // { host-name = "rpi"; };
        #   modules = pre-mods ++ [ inputs.raspberry-pi-nix.nixosModules.raspberry-pi ./rpi.nix ];
        #   format = "iso";
        # };
        pkgs = import inputs.nixpkgs { inherit system; };
      in rec {
        iso = inputs.nixos-generators.nixosGenerate (isoargs // { inherit pkgs; });
        sd = inputs.nixos-generators.nixosGenerate (sdargs // { inherit pkgs; });
        rpi = pkgs.callPackage ./rpi/image_builder.nix { inherit pkgs inputs; rpiSys = nixosConfigurations.rpi; };
        linode = inputs.nixos-generators.nixosGenerate (linodeargs // { inherit pkgs; });
        default = rpi;
        cross = (inputs.flake-utils.lib.eachDefaultSystem (sys: 
        let
          pkgs = import inputs.nixpkgs { localSystem = system; crossSystem = sys; };
        in rec {
          iso = inputs.nixos-generators.nixosGenerate (isoargs // { inherit pkgs; system = sys; });
          sd = inputs.nixos-generators.nixosGenerate (sdargs // { inherit pkgs; system = sys; });
          rpi = pkgs.callPackage ./rpi/image_builder.nix { inherit pkgs inputs; rpiSys = nixosConfigurations.cross.rpi.${sys}; };
          linode = inputs.nixos-generators.nixosGenerate (linodeargs // { inherit pkgs; system = sys; });
          default = rpi;
        }));
      };
      apps = rec {
        test = {
          type = "app";
          program = ./nix/scripts/test.sh;
        };
        build = {
          type = "app";
          program = ./nix/scripts/build.sh;
        };
        ciBuild = {
          type = "app";
          program = ./nix/scripts/ci-build.sh;
        };
        default = build;
      };
    });
  in
  outs // {
    nixosConfigurations = outs.nixosConfigurations // outs.nixosConfigurations."x86_64-linux";
  };
}