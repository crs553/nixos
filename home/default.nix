{ config, pkgs, inputs, ... }:

let
  # Import Neovim configuration from ./nvim/default.nix
  neovimConfig = import ./nvim/default.nix { inherit config pkgs inputs; };
in
{
  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # All programs in a single block
  programs = {
    # Neovim from your separate config
    neovim = neovimConfig.programs.neovim;

    # Other programs
    btop.enable = true;

    firefox = {
      enable = true;
      languagePacks = [ "en-GB" ];
      profiles.default = {
        settings = {
          "browser.startup.homepage" = "https://homepage.lab.charlierstubbs.com";
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

