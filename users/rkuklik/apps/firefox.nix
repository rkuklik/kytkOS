{
  os,
  pkgs,
  inputs,
  ...
}: let
  preferences = {
    "browser.tabs.warnOnClose" = true;
    "network.cookie.cookieBehavior" = 1;
    "network.dns.disablePrefetch" = true;
    "privacy.userContext.ui.enabled" = true;
  };
  addons = import inputs.firefox-addons.outPath {inherit (pkgs) fetchurl lib stdenv;};
in {
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "cs"
    ];
    policies = {
      DisableAppUpdate = true;
      Preferences =
        builtins.mapAttrs
        (_: value: {
          Value = value;
          Status = "locked";
        })
        preferences;
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
    };
    profiles.main = {
      id = 0;
      containersForce = true;
      bookmarks = [];
      extensions = with addons; [
        ublock-origin
        keepassxc-browser
        plasma-integration
        enhancer-for-youtube
        i-dont-care-about-cookies
        clearurls
        facebook-container
        darkreader
        return-youtube-dislikes
        multi-account-containers
      ];
      settings = {
        "app.shield.optoutstudies.enabled" = false;
        "browser.search.region" = "CZ";
        "devtools.cache.disabled" = true;
        "devtools.command-button-measure.enabled" = true;
        "devtools.command-button-rulers.enabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.dom.enabled" = true;
        "devtools.everOpened" = true;
        "extensions.autoDisableScopes" = 0;
        "identity.fxaccounts.account.device.name" = "${os.kytkos.net.hostname}.rkuklik.firefox";
        "identity.fxaccounts.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "reader.color_scheme" = "dark";
      };
      search = {
        force = true;
        default = "Startpage";
        order = [
          "Startpage"
          "DuckDuckGo"
          "Wikipedia (en)"
          "MyNixOS"
          "MDN"
          "Lib.rs"
          "YouTube"
          "Google"
        ];
        engines = {
          "Lib.rs" = {
            urls = [{template = "https://lib.rs/search?q={searchTerms}";}];
            description = "Rust packages/libraries/programs";
            definedAliases = ["!l" "@lib"];
          };
          "Docs.rs" = {
            urls = [{template = "https://docs.rs/releases/search?query={searchTerms}";}];
            description = "Search for crate documentation on docs.rs";
            definedAliases = ["!d" "@docs"];
          };
          "MDN" = {
            urls = [{template = "https://developer.mozilla.org/en-US/search?q={searchTerms}";}];
            description = "Mozilla web docs";
          };
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["!p" "@np"];
          };
          "Noogle" = {
            urls = [{template = "https://noogle.dev/q?term={searchTerms}";}];
            definedAliases = ["!n" "@no"];
          };
          "MyNixOS" = {
            urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
            definedAliases = ["!o" "@mn"];
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
            definedAliases = ["!s" "@start"];
          };
          "YouTube" = {
            urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}&page={startPage?}&utm_source=opensearch";}];
            description = "Search for videos on YouTube";
            definedAliases = ["!y" "@yt"];
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
