{ pkgs ? import <nixpkgs> {}, pkg ? "", exec ? "/bin/", icon ? "", name ? "", path-config ? "", terminal ? "False", type ? "Application", args ? "", ... }:
pkgs.stdenv.mkDerivation 
rec {
  pname = "generate-desktop-file";
  version = "v1.0.0";

  src = ./.;

  installPhase = 
  let
  kc = "${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5";
  in
  ''

  mkdir -p $out/autostart/

  ${kc} --file $out/autostart/${name}.desktop --group "Desktop Entry" --key Exec "${pkg + exec + name + " " + args}"
  ${kc} --file $out/autostart/${name}.desktop --group "Desktop Entry" --key Icon "${icon}"
  ${kc} --file $out/autostart/${name}.desktop --group "Desktop Entry" --key Name "${name}"
  ${kc} --file $out/autostart/${name}.desktop --group "Desktop Entry" --key Path "${path-config}"
  ${kc} --file $out/autostart/${name}.desktop --group "Desktop Entry" --key Terminal "${terminal}"
  ${kc} --file $out/autostart/${name}.desktop --group "Desktop Entry" --key Type "${type}"

  '';

  meta = {
    description = "Generates a desktop file";
    homepage = "https://github.com/tnichols217/nixos-config";
    # license = pkgs.stdenv.lib.licenses.gpl2;
    # platforms = pkgs.stdenv.lib.platforms.all;
  };
}