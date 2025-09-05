{ config, pkgs, ... }:

{
  home.username = "charlie";          # change to your username
  home.homeDirectory = "/home/charlie";

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = builtins.readFile ./nvim/option.lua;
  };

  home.stateVersion = "25.05";  # match your NixOS version
}

