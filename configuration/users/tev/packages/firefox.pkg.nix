{ pkgs, attrs, config, ... }:

let 
  firefox_exts = config.nur.repos.rycee.firefox-addons;
in
pkgs.wrapFirefox pkgs.firefox-devedition {
  nixExtensions = with firefox_exts; let
    fetchFFAddon = pkgs.callPackage (import ./firefox/fetchFirefoxAddonFlake.metapkg.nix) {};
  in
    pkgs.lib.lists.forEach (builtins.attrNames (builtins.readDir (attrs.program-extensions.packages."x86_64-linux".default + "/firefox"))) (x: 
      let 
        name = attrs.program-extensions.packages."x86_64-linux".default + "/firefox/" + x;
      in
      fetchFFAddon name
    )
    #  ++ [
    #   ublock-origin
    #   darkreader
    #   sponsorblock
    #   videospeed
    #   ipfs-companion
    #   simplelogin
    # ]
    ;

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
      Add = [
        {
          Name = "You.com/code";
          Description = "The world's only democratized search platform.";
          Alias = "";
          Method = "POST";
          URLTemplate = "https://you.com/search?q={searchTerms}&tbm=youcode";
        }
      ];
    };
  };

  extraPrefs = builtins.readFile (pkgs.callPackage ./firefox/overrideSetting.metapkg.nix { 
      input-file = attrs.librewolfConfig + "/librewolf.cfg"; 
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
    '' ;
}
