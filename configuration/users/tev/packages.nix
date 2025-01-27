{ config, pkgs, username, host-name, vscode_exts, openvsx_exts, addresses, inputs,  ... }:
let
ssh = {
  enable = true;
  matchBlocks = let 
    identityFile = "/home/${username}/.ssh/ed25519";
    identityFileAWS = "/home/${username}/.ssh/ROG.pem";
    identityFileAI4EDU = "/home/${username}/.ssh/AI4EDU.pem";
    user = "${username}";
    port = 22;
    # port = 27180;
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
      hostname = "${addresses.asus}";
      inherit user port identityFile;
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
  };
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # utils
        cachix
        wl-clipboard
        grim
        slurp
        rofi
        jq
        gnupg
        poppler
        libsForQt5.qt5.qttools
        fswatch
        konsole
        meld
        neofetch
        gparted
        podman
        yarn
        nodejs
        nodePackages.nodemon
        nodePackages.npm
        openjdk17-bootstrap
        virt-manager
        ark
        pstree
        scrcpy
        android-tools
        plasma-browser-integration
        ipfs
        dotnet-sdk
        pandoc
        rustc
        cargo
        # nvtopPackages.full
        qpwgraph
        yt-dlp
        ffmpeg
        libtpms
        swtpm
        piper
        darling-dmg
        # miraclecast
        mpv
        imagemagick
        hyprpaper
        xplr
        # pdfslicer
        pdfsam-basic
        # sonic-visualiser
        xsettingsd
        wacomtablet
        config.boot.kernelPackages.usbip
        sunshine
        dconf
        openfortivpn
        xautomation
        xbindkeys
        ani-cli
        (pkgs.callPackage ./packages/ani-cli-batch.pkg.nix { inherit inputs; })
        # mov-cli
        graphviz
        texliveFull
        pstoedit
        playerctl
        parallel
        nautilus
        kdePackages.ksshaskpass
        kdePackages.okular
        units
        libnotify

        # programs
        anki
        filezilla
        filelight
        libreoffice
        # Davinci doesnt work on the latest nixpkgs
        # davinci-resolve
        # (pkgs.callPackage ./packages/davinci.nix {})
        signal-desktop
        lolcat
        htop
        kcalc
        libsForQt5.kdeconnect-kde
        # musescore cmake broken
        # pureref # because of ci build failiures
        audacity
        lutris
        dolphin-emu
        qbittorrent
        calibre
        krita
        btop
        tidal-hifi
        moonlight-qt
        korganizer
        # tartube-yt-dlp
        element-desktop
        jellyfin-media-player
        jellycli
        (rstudioWrapper.override {
          packages = with rPackages; [ ggplot2 dplyr xts languageserver httpgd ];
        })
        (rWrapper.override {
          packages = with rPackages; [ ggplot2 dplyr xts languageserver httpgd tidyverse ];
        })


        # vscode

        obsidian
        stremio
        # barrier
        input-leap
        flameshot
        spotify
        gimp
        (inkscape-with-extensions.override { inkscapeExtensions = [ inkscape-extensions.textext ]; } )
          ghostscript
          optipng
          fig2dev
          scribus
        brave
        # teams

        (discord.override {
          withOpenASAR = true;
          withVencord = true;
        })
        tdesktop
        whatsapp-for-linux
        # minecraft
        prismlauncher
        localsend
        osu-lazer
        uiua
        ryujinx
        inputs.suyu.packages.x86_64-linux.suyu
        torzu
        (pkgs.callPackage ./packages/display3d.pkg.nix {})
        # tartube-yt-dlp
        android-studio

        # python
        (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
          ipykernel
          pandas
          scikit-learn
          pip
          numpy
          scipy
          sympy
          matplotlib
          radian
        ]))

        inputs.nix-matlab.packages.x86_64-linux.matlab
        inputs.lockdev-redirect.packages.x86_64-linux.lockdev-redirect
        
        (callPackage ./packages/arch-theme.pkg.nix { arch-theme = inputs.arch-theme; })
        (callPackage ./packages/papirus-icons.pkg.nix { papirus = inputs.papirus; })
        (callPackage ./packages/kwin-scripts.pkg.nix {})
        (callPackage ./packages/konsole-themes.pkg.nix {})
        (callPackage ./packages/firefox.pkg.nix { inherit inputs config; })
      ] ++ (if host-name == "ASUS" then [
        # (blender.override { cudaSupport = true; } )
        # Blender build is broken right now??
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
  # programs = {
  #   inherit ssh;
  # };
}
