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

  # Add packages to your user environment
  home.packages = with pkgs; [
    cowsay
    fortune

    mullvad-browser

    vlc
    feh
  ];
}

