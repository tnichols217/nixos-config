{ username }:
{ config, pkgs, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/data" = {
    hideMounts = false;
    users.${username} = {
      directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "VirtualBox VMs"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          { directory = ".nixops"; mode = "0700"; }
          { directory = ".local/share/keyrings"; mode = "0700"; }
          ".local/share/direnv"
      ];
      files = [
      ];
    };
  };

  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/local" = {
    hideMounts = false;
    users.${username} = {
      directories = [
        ".local"
      ];
    };
  };

  # environment.persistence."/nix/persist/etc/nixos/configuration/persistence/config" = {
  #   hideMounts = false;
  #   users.${username} = {
  #     directories = [
  #       ".config/gtk-3.0"
  #       ".config/gtk-4.0"
  #       ".config/KDE"
  #       ".config/kde.org"
  #       ".config/plasma-workspace"
  #       ".config/xsettingsd"
  #       ".kde"
  #     ];
  #     files = [
  #       ".screenrc"

  #       ".config/akregatorrc"
  #       ".config/baloofileinformationrc"
  #       ".config/baloofilerc"
  #       ".config/bluedevilglobalrc"
  #       ".config/device_automounter_kcmrc"
  #       ".config/dolphinrc"
  #       ".config/filetypesrc"
  #       ".config/gtkrc"
  #       ".config/gtkrc-2.0"
  #       ".config/gwenviewrc"
  #       ".config/kactivitymanagerd-pluginsrc"
  #       ".config/kactivitymanagerd-statsrc"
  #       ".config/kactivitymanagerd-switcher"
  #       ".config/kactivitymanagerdrc"
  #       ".config/katemetainfos"
  #       ".config/katerc"
  #       ".config/kateschemarc"
  #       ".config/katevirc"
  #       ".config/kcmfonts"
  #       ".config/kcminputrc"
  #       ".config/kconf_updaterc"
  #       ".config/kded5rc"
  #       ".config/kdeglobals"
  #       ".config/kgammarc"
  #       ".config/kglobalshortcutsrc"
  #       ".config/khotkeysrc"
  #       ".config/kmixrc"
  #       ".config/konsolerc"
  #       ".config/kscreenlockerrc"
  #       ".config/ksmserverrc"
  #       ".config/ksplashrc"
  #       ".config/ktimezonedrc"
  #       ".config/kwinrc"
  #       ".config/kwinrulesrc"
  #       ".config/kxkbrc"
  #       ".config/mimeapps.list"
  #       ".config/partitionmanagerrc"
  #       ".config/plasma-localerc"
  #       ".config/plasma-nm"
  #       ".config/plasma-org.kde.plasma.desktop-appletsrc"
  #       ".config/plasmanotifyrc"
  #       ".config/plasmarc"
  #       ".config/plasmashellrc"
  #       ".config/PlasmaUserFeedback"
  #       ".config/plasmawindowed-appletsrc"
  #       ".config/plasmawindowedrc"
  #       ".config/powermanagementprofilesrc"
  #       ".config/spectaclerc"
  #       ".config/startkderc"
  #       ".config/systemsettingsrc"
  #       ".config/Trolltech.conf"
  #       ".config/user-dirs.dirs"
  #       ".config/user-dirs.locale"
  #     ];
  #   };
  # };
}