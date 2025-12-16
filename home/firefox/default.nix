{ config, pkgs, inputs, ... }:
{
  firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];
    profiles.default = {
      settings = {
        "browser.startup.homepage" = "https://homepage.lab.charlierstubbs.com";
      };

      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
      ];
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

}
