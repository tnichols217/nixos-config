{ stdenv, unzip, jq, zip, fetchurl,writeScript, ... }:

{ name, source }:

let
  extid = "nixos@${name}";
in
stdenv.mkDerivation {
  inherit name;

  passthru = {
    inherit extid;
  };

  builder = writeScript "xpibuilder" ''
    source $stdenv/setup
    header "firefox addon $name into $out"
    UUID="${extid}"
    mkdir -p "$out/$UUID"
    unzip -q ${source} -d "$out/$UUID"
    NEW_MANIFEST=$(jq '. + {"applications": { "gecko": { "id": "${extid}" }}, "browser_specific_settings":{"gecko":{"id": "${extid}"}}}' "$out/$UUID/manifest.json")
    echo "$NEW_MANIFEST" > "$out/$UUID/manifest.json"
    cd "$out/$UUID"
    zip -r -q -FS "$out/$UUID.xpi" *
    rm -r "$out/$UUID"
  '';
  nativeBuildInputs = [ unzip zip jq  ];
}