{ inputs, pkgs, username, ff-exts, ... }:

{
  home-manager.users.${username} = {
    programs = {
      firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-devedition-unwrapped {
          extraPrefs = builtins.readFile (pkgs.callPackage ./firefox/overrideSetting.metapkg.nix { 
            input-file = inputs.librewolfConfig + "/librewolf.cfg"; 
            overrides = [ 
              { 
                re = "network.dns.disableIPv6";
                wi = ''defaultPref(\"network.dns.disableIPv6\", false);'';
              }
              { 
                re = "webgl.disabled";
                wi = ''defaultPref(\"webgl.disabled\", false);'';
              }
              { 
                re = "media.peerconnection.ice.no_host";
                wi = ''defaultPref(\"media.peerconnection.ice.no_host\", false);'';
              }
            ];
          } + "/conf" ) + ''
            defaultPref("privacy.clearOnShutdown.history", false);
            defaultPref("privacy.clearOnShutdown.downloads", false);
            defaultPref("privacy.clearOnShutdown.sessions", false);
            defaultPref("privacy.clearOnShutdown.cache", false);
            defaultPref("privacy.clearOnShutdown.cookies", false);
            defaultPref("privacy.clearOnShutdown.offlineApps", false);
            defaultPref("security.identityblock.show_extended_validation", true);
            defaultPref("browser.tabs.insertAfterCurrent", true);
            defaultPref("dom.importMaps.enabled", true);
            defaultPref("signon.autofillForms", true);
            defaultPref("signon.rememberSignons", true);
            defaultPref("places.history.enabled", false);
            defaultPref("privacy.userContext.newTabContainerOnLeftClick.enabled", true);
          '' ;
        };
        policies = {
          DisableAppUpdate = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DisableSystemAddonUpdate = true;
          DisableProfileImport = false;
          DisableFirefoxStudies = true;
          DisableTelemetry = true;
          DisableFeedbackCommands = true;
          DisablePocket = true;
          DisableDeveloperTools = false;
          CaptivePortal = false;
          DisableFirefoxAccounts = true;
          NoDefaultBookmarks = true;
          WebsiteFilter = {
            Block = [ "https://localhost/*" ];
            Exceptions = [ "https://localhost/*" ];
          };
          FirefoxHome = {
            Pocket = false;
            Snippets = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
          SearchEngines = {
            Remove = [ 
              "Google"
              "Bing"
              "Amazon.com"
              "eBay"
              "Twitter"
            ];
            Add = [
              {
                Name = "NixOS Search";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                Alias = "nix";
              }
            ];
            Default = "DuckDuckGo";
          };
        };
        profiles = {
          "default.dev-edition-default" = {
            name = "dev-edition-default";
            extensions.packages = with ff-exts; [
              ublock-origin
              darkreader
              sponsorblock
              videospeed
              # ipfs-companion
              tiled-tab-groups
              nicothin-space
              clut-cycle-last-used-tabs
              better-canvas
              hls-downloader
              cliget
              bitwarden-password-manager
            ];
            containers = {
              case = {
                color = "blue";
                icon = "briefcase";
                id = 1;
              };
              coding = {
                color = "green";
                icon = "fence";
                id = 2;
              };
              personal = {
                color = "red";
                icon = "fingerprint";
                id = 3;
              };
              music = {
                color = "turquoise";
                icon = "circle";
                id = 4;
              };
            };
          };
        };
      };
    };
  };
}