{ config, pkgs, username, attrs, host-name, nixpkgs, oldpkgs, vscode_exts, openvsx_exts, addresses, ... }:
let
ssh = {
  enable = true;
  matchBlocks = let 
    identityFile = "/home/${username}/.ssh/ed25519";
    identityFileAWS = "/home/${username}/.ssh/ROG.pem";
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
    "gh" = {
      hostname = "github.com";
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
  # users.users.jupyter.group = "jupyter";
  # users.groups.jupyter = {};
  # services.jupyter = {
  #   enable = true;
  #   password = "sha1:1b961dc713fb:88483270a63e57d18d43cf337e629539de1436ba";
  #   kernels = {
  #     python3 = let
  #       env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
  #               ipykernel
  #               pandas
  #               scikit-learn
  #             ]));
  #     in {
  #       displayName = "Python 3 for machine learning";
  #       argv = [
  #         "${env.interpreter}"
  #         "-m"
  #         "ipykernel_launcher"
  #         "-f"
  #         "{connection_file}"
  #       ];
  #       language = "python";
  #       # logo32 = ${env.sitePackages}/ipykernel/resources/logo-32x32.png;
  #       # logo64 = ${env.sitePackages}/ipykernel/resources/logo-64x64.png;
  #     };
  #   };
  # };
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # utils
        cachix
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
        openjdk16-bootstrap
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
        nvtopPackages.full
        qpwgraph
        yt-dlp
        ffmpeg
        libtpms
        swtpm
        piper
        darling-dmg
        miraclecast
        mpv
        imagemagick
        # pdfslicer
        pdfsam-basic
        sonic-visualiser
        xsettingsd
        wacomtablet
        config.boot.kernelPackages.usbip
        sunshine
        dconf
        openfortivpn
        xautomation
        xbindkeys
        ani-cli
        (pkgs.callPackage ./packages/ani-cli-batch.pkg.nix { inherit attrs; })
        mov-cli
        graphviz
        texliveFull
        pstoedit

        # programs
        anki
        filezilla
        filelight
        libreoffice
        # Davinci doesnt work on the latest nixpkgs
        davinci-resolve
        # (pkgs.callPackage ./packages/davinci.nix {})
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
        tartube-yt-dlp
        element-desktop
        jellyfin-media-player
        jellycli

        # vscode

        obsidian
        stremio
        # barrier
        input-leap
        flameshot
        spotify
        (blender-hip.override { cudaSupport = true; } )
        gimp
        (inkscape-with-extensions.override { inkscapeExtensions = [ inkscape-extensions.textext ]; } )
          ghostscript
          optipng
          fig2dev
          scribus
        brave
        # teams

        discord
        tdesktop
        whatsapp-for-linux
        minecraft
        prismlauncher
        localsend
        osu-lazer
        tartube-yt-dlp

        # python
        (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
          ipykernel
          pandas
          scikit-learn
          pip
          numpy
          scipy
          matplotlib
        ]))
        
        (callPackage ./packages/arch-theme.pkg.nix { arch-theme = attrs.arch-theme; })
        (callPackage ./packages/papirus-icons.pkg.nix { papirus = attrs.papirus; })
        (callPackage ./packages/kwin-scripts.pkg.nix {})
        (callPackage ./packages/konsole-themes.pkg.nix {})
        (callPackage ./packages/firefox.pkg.nix { inherit attrs config; })
      ];
    };
    programs = {
      inherit ssh; 
      vscode = import ./packages/vscode.nix ({ inherit pkgs attrs config vscode_exts openvsx_exts; });
      obs-studio = {
        enable = true;
      };
    };
  };
  programs = {
    inherit ssh;
  }
}
