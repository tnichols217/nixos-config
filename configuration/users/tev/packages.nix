{ config, pkgs, username, attrs, host-name, nixpkgs, oldpkgs, vscode_exts, openvsx_exts, ... }:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # utils
        cachix
        gnupg
        poppler
        libsForQt5.qt5.qttools
        fswatch
        python3
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
        nvtop
        qpwgraph
        yt-dlp
        ffmpeg
        libtpms
        swtpm
        piper
        darling-dmg
        comma
        miraclecast
        mpv
        imagemagick
        pdfslicer
        sonic-visualiser

        # programs
        filezilla
        filelight
        libreoffice
        # Davinci doesnt work on the latest nixpkgs
        oldpkgs.davinci-resolve
        lolcat
        htop
        kcalc
        libsForQt5.kdeconnect-kde
        musescore
        pureref
        audacity
        lutris
        dolphin-emu

        # vscode

        obsidian
        stremio
        barrier
        flameshot
        spotify
        (blender.override { cudaSupport = true; } )
        gimp
        inkscape
        brave
        teams

        discord
        tdesktop
        whatsapp-for-linux
        minecraft
        prismlauncher

        osu-lazer
        
        (callPackage ./packages/arch-theme.pkg.nix { arch-theme = attrs.arch-theme; })
        (callPackage ./packages/papirus-icons.pkg.nix { papirus = attrs.papirus; })
        (callPackage ./packages/kwin-scripts.pkg.nix {})
        (callPackage ./packages/konsole-themes.pkg.nix {})
        (callPackage ./packages/firefox.pkg.nix { inherit attrs config; })
      ];
    };
    programs = {
      ssh = {
        enable = true;
        matchBlocks = let 
          identityFile = "/home/${username}/.ssh/ed25519";
          identityFileRsa = "/home/${username}/.ssh/rsa";
          user = "${username}";
          port = 22;
          # port = 27180;
        in {
          "MSI" = {
            hostname = "192.168.100.250";
            inherit user port identityFile;
          };
          "ASUS" = {
            hostname = "192.168.100.200";
            inherit user port identityFile;

          };
          "heyo" = {
            hostname = "heyo.ydns.eu";
            inherit user port identityFile;

          };
          "pigs" = {
            hostname = "pigsgo.mooo.com";
            inherit user port identityFile;
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
      vscode = import ./packages/vscode.nix ({ inherit pkgs attrs config vscode_exts openvsx_exts; });
      obs-studio = {
        enable = true;
      };
    };
  };
}
