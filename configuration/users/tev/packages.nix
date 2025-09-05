{ config, pkgs, username, host-name, vscode_exts, openvsx_exts, addresses, inputs, ports, ... }:
let
ssh = {
  enable = true;
  matchBlocks = let 
    identityFile = "/home/${username}/.ssh/ed25519";
    identityFileAWS = "/home/${username}/.ssh/ROG.pem";
    identityFileAI4EDU = "/home/${username}/.ssh/AI4EDU.pem";
    user = "${username}";
    port = 22;
  in {
    "MSI" = {
      hostname = "${addresses.msi}";
      inherit user port identityFile;
    };
    "ROG" = {
      hostname = "${addresses.rog}";
      inherit user port identityFile;
    };
    "ASUS" = {
      hostname = "${addresses.default}";
      port = ports.ssh;
      inherit user identityFile;
    };
    "AWS" = {
      hostname = "${addresses.default}";
      identityFile = identityFileAWS;
      inherit user port;
    };
    "AWST" = {
      hostname = "${addresses.default}";
      identityFile = identityFileAWS;
      port = 2222;
    };
    "AIEDU" = {
      inherit port;
      hostname = "3.137.184.99";
      identityFile = identityFileAI4EDU;
      user = "ec2-user";
    };
    "M" = {
      inherit port identityFile;
      user = "tln32";
      hostname = "markov.case.edu";
    };
    "DLL" = {
      inherit port identityFile;
      hostname = "cse-d3kgsk74";
      user = "tln32";
    };
    "gh" = {
      hostname = "github.com";
      user = "git";
      inherit identityFile;
    };
    "bb" = {
      hostname = "bitbucket.org";
      user = "git";
      inherit identityFile;
    };
    "*" = {
      inherit identityFile;
    };
  };
};
in
{
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_WL = "1";
  };
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # WM
        hyprpaper

        # Learning
        anki
        obsidian
        graphviz

        # Utils
        sshfs
        libnotify
        dconf
        wacomtablet
        xsettingsd
        config.boot.kernelPackages.usbip
        piper
        xbindkeys
        xautomation
        libtpms
        swtpm
        libsForQt5.qt5.qttools
        openfortivpn
        kdePackages.ksshaskpass

        # Apps
        qbittorrent
        libsForQt5.kdeconnect-kde
        virt-manager
        kdePackages.filelight
        filezilla
        libreoffice
        brave
        kdePackages.okular
        nautilus
        pdfsam-basic
        mpv
        kdePackages.ark
        asunder
        kdePackages.elisa
        gparted
        texliveFull

        # Tools
        htop
        btop
        kdePackages.kcalc
        lolcat
        localsend
        flameshot
        # (pkgs.callPackage ./packages/display3d.pkg.nix {})
        xplr
        qpwgraph
        parallel
        units
        pstoedit
        ipfs
        yt-dlp
        ffmpeg
        scrcpy
        wl-clipboard
        grim
        slurp
        rofi
        jq
        gnupg
        pstree
        fswatch
        cachix
        poppler
        neofetch
        pandoc
        imagemagick

        # Art
        gimp
        (inkscape-with-extensions.override { inkscapeExtensions = [ inkscape-extensions.textext ]; } )
          ghostscript
          optipng
          fig2dev
          scribus
        krita
        audacity

        # Messaging
        tdesktop
        whatsapp-for-linux
        element-desktop
        signal-desktop

        # Media
        spotify
        stremio
        jellyfin-media-player
        jellycli
        tidal-hifi
        calibre
        playerctl
        ani-cli
        (pkgs.callPackage ./packages/ani-cli-batch.pkg.nix { inherit inputs; })

        # Games
        sunshine
        dolphin-emu
        lutris
        moonlight-qt
        osu-lazer
        prismlauncher
        (pkgs.callPackage ./packages/torzu.pkg.nix {})
        ryujinx

        # Programming Tools
        android-studio
        bruno
        podman
        yarn
        android-tools
        meld

        # Programming Languages
        nodejs
        nodePackages.nodemon
        openjdk17-bootstrap
        dotnet-sdk
        rustc
        cargo
        uiua
        (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
          ipykernel
          pandas
          scikit-learn
          pip
          numpy
          scipy
          sympy
          matplotlib
          pyyaml
          nbformat
          nbclient
          jupyter
        ]))
        julia
        quarto
        (rWrapper.override {
          packages = with rPackages; [ ggplot2 dplyr xts languageserver tidyverse ];
        })
        inputs.nix-matlab.packages."${system}".matlab
        
        # Theming
        (callPackage ./packages/arch-theme.pkg.nix { arch-theme = inputs.arch-theme; })
        (callPackage ./packages/papirus-icons.pkg.nix { papirus = inputs.papirus; })
        (callPackage ./packages/kwin-scripts.pkg.nix {})
        # (callPackage ./packages/konsole-themes.pkg.nix {})

        # Customized packages
        (callPackage ./packages/firefox.pkg.nix { inherit inputs config; })
        (discord.override {
          withOpenASAR = true;
          withVencord = true;
        })

        # Broken things
        # Davinci doesnt work on the latest nixpkgs
        davinci-resolve
        # (pkgs.callPackage ./packages/davinci.nix {})
        # musescore cmake broken
        # pureref # because of ci build failiures
        # pdfslicer
        # sonic-visualiser
        # nvtopPackages.full
        # miraclecast
        # darling-dmg # Build broken
      ] ++ (if host-name == "ASUS" then [
        # (blender.override { cudaSupport = true; } )
      ] else [
        blender-hip
      ]);
    };
    programs = {
      inherit ssh; 
      vscode = import ./packages/vscode.nix ({ inherit pkgs inputs config vscode_exts openvsx_exts; });
      obs-studio = {
        enable = true;
      };
    };
  };
}
