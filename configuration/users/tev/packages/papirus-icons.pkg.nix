{ pkgs ? import <nixpkgs> {}, papirus, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "papirus-icon-theme";
  version = "20220606";

  src = papirus

  dontDropIconThemeCache = true;

  installPhase = ''
    mkdir -p $out/share/icons
    cp -a Papirus* $out/share/icons
  '';

  meta = with pkgs.lib; {
    description = "Papirus is a free and open source SVG icon theme for Linux";
    homepage = "https://github.com/PapirusDevelopmentTeam/papirus-icon-theme";
    license = [ licenses.gpl3Only ];
    platforms = platforms.linux;
  };
}