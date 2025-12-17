{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nvim
    ./firefox
    ./starship
    ./zsh
    ./zoxide
  ];

  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.btop.enable = true;

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
  # Add packages to your user environment
  home.packages = with pkgs; [
    fortune
    vlc
    mullvad-browser
    feh   cowsay   # optional, goes well with fortune
  ];
}

