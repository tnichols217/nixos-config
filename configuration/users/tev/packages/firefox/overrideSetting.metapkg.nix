{ pkgs ? import <nixpkgs> {}, input-file ? ./test, overrides ? [{re="c"; wi="d";}], ... }:
pkgs.stdenv.mkDerivation 
rec {
  pname = "override firefox config file";
  version = "v1.0.0";

  src = ./.;

  installPhase = 
  let
  intro = "sed -i \"s/[^\\n]*";
  outro = "/\" $out/conf \n";
  concat = intro + pkgs.lib.concatStringsSep (outro + intro) (pkgs.lib.lists.forEach overrides ( x: x.re + "[^\\n]*/" + x.wi )) + outro;
  in ''

  mkdir $out

  cp ${input-file} $out/conf

  ${concat}

  cat $out/conf

  echo ""

  '';

  meta = {
    description = "Combines two deriviations (for config files)";
    homepage = "https://github.com/tnichols217/nixos-config";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.all;
  };
}