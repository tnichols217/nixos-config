{ pkgs, ... }:

# I might finish this another if i find it useful enough

pkgs.stdenv.mkDerivation rec {
  pname = "shortcuts";
  version = "v1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cd $out/bin
    echo "xclip -selection clipboard -r" > clip
    echo "git add -A && git commit -am \$1" > gac
    echo "git push" > gp
    echo "git pull" > gpl
    echo ""
    chmod +x *
  '';

  meta = with pkgs.lib; {
    description = "Global shortcuts for my convenience";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = [ licenses.gpl3Only ];
    platforms = platforms.linux;
  };
}