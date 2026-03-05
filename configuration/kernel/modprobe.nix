{ ... }:
{
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="module", RUN+="${pkgs.modprobed-db}/bin/modprobed-db store -p /var/lib/modprobed.db"
  '';
}