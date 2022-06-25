{ pkgs, attrs, ... }:

pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
  nixExtensions = let
  fetchFFAddon = pkgs.callPackage (import ./firefox/fetchFirefoxAddonFlake.nix) {};
  in [
    ( fetchFFAddon {
      name = "ublock";
      source = attrs.ublock;
    } )
    ( fetchFFAddon {
      name = "dark-reader";
      source = attrs.dark-reader;
    } )
    ( fetchFFAddon {
      name = "sponsorblock";
      source = attrs.sponsorblock;
    } )
    ( fetchFFAddon {
      name = "videospeed-controller";
      source = attrs.videospeed-controller;
    } )
    ( fetchFFAddon {
      name = "tiled-tab-groups";
      source = attrs.tiled-tab-groups;
    } )
  ];

  extraPolicies = {

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
      Default = "DuckDuckGo";
      Add = {
        {
          Name = "You.com/code";
          Description = "The world's only democratized search platform.";
          Alias = "";
          Method = "POST";
          URLTemplate = "https://you.com/search?q=(searchTerms)&tbm=youcode";
        }
      }
    };
  };

  extraPrefs = (builtins.readFile attrs.librewolfConfig) + ''
    defaultPref("network.dns.disableIPv6", false);
    defaultPref("webgl.disabled", false);
    defaultPref("media.peerconnection.ice.no_host", false);
    defaultPref("privacy.clearOnShutdown.history", false);
    defaultPref("privacy.clearOnShutdown.downloads", false);
    defaultPref("security.identityblock.show_extended_validation", true);
  '';
}
