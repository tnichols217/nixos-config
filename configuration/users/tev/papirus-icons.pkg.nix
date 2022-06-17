{ pkgs ? import <nixpkgs> {}, 
  themes ? "Papirus*",
  ...
}:

pkgs.stdenv.mkDerivation rec {
  pname = "papirus-icon-theme";
  version = "20220606";

  src = pkgs.fetchFromGitHub {
    owner = "PapirusDevelopmentTeam";
    repo = pname;
    rev = version;
    sha256 = "sha256-HJb77ArzwMX9ZYTp0Ffxxtst1/xhPAa+eEP5n950DSs=";
  };

  dontDropIconThemeCache = true;

  installPhase = ''
    mkdir -p $out/share/icons
    cp -a ${themes} $out/share/icons
  '';

  meta = with pkgs.lib; {
    description = "Papirus is a free and open source SVG icon theme for Linux";
    homepage = "https://github.com/PapirusDevelopmentTeam/papirus-icon-theme";
    license = [ licenses.gpl3Only ];
    platforms = platforms.linux;
  };
}