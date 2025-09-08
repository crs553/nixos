{ config, pkgs, ... }:
{

  home.username      = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.05";   # Must match the NixOS stateVersion

  programs.home-manager.enable = true;

}

