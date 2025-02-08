{
  os,
  pkgs,
  inputs,
  ...
}:
let
  lock = value: {
    Value = value;
    Status = "locked";
  };
  day = 24 * 60 * 60 * 1000;
  updateInterval = day;
  addons = import inputs.firefox-addons.outPath { inherit (pkgs) fetchurl lib stdenv; };
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "cs"
    ];
    policies = {
      Preferences = {
        "browser.link.open_newwindow" = lock 3;
        "browser.newtabpage.activity-stream.feeds.topsites" = lock false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = lock "";
        "browser.newtabpage.activity-stream.showSponsored" = lock false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = lock false;
        "browser.newtabpage.activity-stream.telemetry" = lock false;
        "browser.newtabpage.pinned" = lock "";
        "browser.vpn_promo.enabled" = lock false;
        "browser.tabs.warnOnClose" = lock true;
        "browser.startup.page" = lock 3;
        "extensions.autoDisableScopes" = lock 0;
        "extensions.getAddons.showPane" = lock false;
        "extensions.htmlaboutaddons.recommendations.enabled" = lock false;
        "network.cookie.cookieBehavior" = lock 1;
        "network.dns.disablePrefetch" = lock true;
        "privacy.globalprivacycontrol.enabled" = lock true;
        "privacy.userContext.enabled" = lock true;
        "privacy.userContext.ui.enabled" = lock true;
      };
      CaptivePortal = false;
      DisableAppUpdate = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "newtab";
      DisplayMenuBar = "default-off";
      EnableTrackingProtection = {
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      ExtensionUpdate = false;
      FirefoxHome = {
        Pocket = false;
        TopSites = false;
        Highlights = false;
        Snippets = false;
      };
      FirefoxSuggest = {
        WebSuggestions = true;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };
      ManualAppUpdateOnly = true;
      NoDefaultBookmarks = true;
      PostQuantumKeyAgreementEnabled = true;
      SearchBar = "unified";
      UserMessaging = {
        ExtensionRecommendations = false;
      };
    };
    profiles.main = {
      id = 0;
      containersForce = true;
      bookmarks = [ ];
      extensions.packages = with addons; [
        i-dont-care-about-cookies
        ublock-origin
        privacy-badger
        clearurls

        multi-account-containers
        facebook-container

        keepassxc-browser
        plasma-integration
        darkreader

        enhancer-for-youtube
        return-youtube-dislikes
      ];
      settings = {
        "accessibility.browsewithcaret" = true;
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.search.region" = "CZ";
        "devtools.cache.disabled" = true;
        "browser.ping-centre.telemetry" = false;
        "devtools.command-button-measure.enabled" = true;
        "devtools.command-button-rulers.enabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.dom.enabled" = true;
        "devtools.everOpened" = true;
        "identity.fxaccounts.account.device.name" = "${os.kytkos.net.hostname}.rkuklik.firefox";
        "identity.fxaccounts.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.trackingprotection.enabled" = true;
        "reader.color_scheme" = "dark";
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
      };
      search = {
        force = true;
        default = "Startpage";
        order = [
          "Startpage"
          "DuckDuckGo"
          "Wikipedia (en)"
          "MyNixOS"
          "MDN Web Docs"
          "Lib.rs"
          "YouTube"
          "Google"
        ];
        engines = {
          "Lib.rs" = {
            urls = [ { template = "https://lib.rs/search?q={searchTerms}"; } ];
            description = "Rust packages/libraries/programs";
            iconUpdateUrl = "https://lib.rs/favicon.png";
            definedAliases = [
              "!l"
              "@lib"
            ];
            inherit updateInterval;
          };
          "Docs.rs" = {
            urls = [ { template = "https://docs.rs/releases/search?query={searchTerms}"; } ];
            description = "Search for crate documentation on docs.rs";
            iconUpdateUrl = "https://docs.rs/-/static/favicon.ico";
            definedAliases = [
              "!d"
              "@docs"
            ];
            inherit updateInterval;
          };
          "MDN Web Docs" = {
            urls = [ { template = "https://developer.mozilla.org/en-US/search?q={searchTerms}"; } ];
            description = "Search the MDN Web Docs";
            iconUpdateUrl = "https://developer.mozilla.org/favicon.ico";
            definedAliases = [
              "!m"
              "@mdn"
            ];
            inherit updateInterval;
          };
          "NixOS packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            description = "Search NixOS packages";
            iconUpdateUrl = "https://search.nixos.org/favicon.png";
            definedAliases = [
              "!p"
              "@np"
            ];
            inherit updateInterval;
          };
          "Noogle" = {
            urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
            description = "Nix API reference";
            iconUpdateUrl = "https://noogle.dev/favicon.png";
            definedAliases = [
              "!n"
              "@no"
            ];
            inherit updateInterval;
          };
          "MyNixOS" = {
            urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
            description = "Build and share reproducible software environments with Nix and NixOS";
            iconUpdateUrl = "https://mynixos.com/favicon-64x64.png";
            definedAliases = [
              "!o"
              "@mn"
            ];
            inherit updateInterval;
          };
          "Startpage" = {
            urls = [
              {
                template = "https://www.startpage.com/do/dsearch?q={searchTerms}&cat=web&language=english";
              }
              {
                template = "https://www.startpage.com/suggestions?q={searchTerms}&format=opensearch&segment=startpage.defaultffx&lui=english";
                type = "application/x-suggestions+json";
              }
            ];
            description = "Startpage Search";
            iconUpdateUrl = "https://www.startpage.com/favicon.ico";
            definedAliases = [
              "!s"
              "@start"
            ];
            inherit updateInterval;
          };
          "YouTube" = {
            urls = [
              {
                template = "https://www.youtube.com/results?search_query={searchTerms}&page={startPage?}&utm_source=opensearch";
              }
            ];
            description = "Search for videos on YouTube";
            iconUpdateUrl = "https://www.youtube.com/favicon.ico";
            definedAliases = [
              "!y"
              "@yt"
            ];
            inherit updateInterval;
          };
          "Wikipedia (en)".metaData.alias = "!w";
          "Google".metaData.alias = "!g";
          "Bing".metaData.hidden = true;
          "Amazon".metaData.hidden = true;
        };
      };
    };
  };
}
