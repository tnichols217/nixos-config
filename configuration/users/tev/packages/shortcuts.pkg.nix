{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "shortcuts";
  version = "v1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cd $out/bin
    echo "echo a" > test1
    chmod +x *
  '';

  meta = with pkgs.lib; {
    description = "Global shortcuts for my convenience";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = [ licenses.gpl3Only ];
    platforms = platforms.linux;
  };
}