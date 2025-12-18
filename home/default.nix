{ config, pkgs, inputs, ... }:

{
  imports = [
    ./firefox
    ./fzf
    ./git
    ./kitty
    ./mpv
    ./nvim
    ./starship
    ./tmux
    ./zoxide
    ./zsh
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

