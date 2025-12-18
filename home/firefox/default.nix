{ config, pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];
    profiles.default = {
      search = {
        force = true;
        default = "kagi";
        privateDefault = "ddg";
        order = ["kagi" "ddg" "google"];
      };


      settings = {
        "browser.startup.homepage" = "https://homepage.lab.charlierstubbs.com";
      };

      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        bitwarden
        sponsorblock
      ];
    };

    policies = {
      SearchEngines = {
        Add = [
          {
            Alias = "@np";
            Description = "Search in NixOS Packages";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Packages";
            URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@no";
            Description = "Search in NixOS Options";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@nw";
            Description = "Search in NixOS Wiki";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Wiki";
            URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}&title=Special%3ASearch&wprov=acrw1_-1";
          }
        ];
      };
      DisableFormHistory = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      DisablePocket = true;

      NetworkPrediction = false;
      # CaptivePortal = false;

      UserMessaging = {
        WhatsNew = false;
        UrlbarInterventions = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;
      };

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      HardwareAcceleration = true;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      # WindowsSSO = false;

      OfferToSaveLogins = false;
      # OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      FirefoxHome = {
        Search = true;
        Pocket = false;
        Snippets = false;
        TopSites = false;
        Highlights = false;
      };

      "3rdparty" = {
        Extensions = {
          "uBlock0@raymondhill.net" = {
            "sidebarPosition" = 1;
            "sidebarPosition:locked" = false;

            adminSettings = {
              "selectedFilterLists" = [
                "ublock-privacy"
                "ublock-badware"
                "ublock-filters"
                "ublock-quick-fixes"
                "ublock-unbreak"
                "user-filters"

                "easylist"
                "easyprivacy"
                "urlhaus-1"
                "plowe-0"

                "easylist-newsletters"

                "fanboy-cookiemonster"
                "ublock-cookies-easylist"

              ];
            };
            userSettings = [
              ["advancedUserEnabled" "true"]
              ["ignoreGeneticCosmeticFilters" "true"]
              ["popupPanelSections" "31"]
            ];
          };
        };

      };
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };


}
