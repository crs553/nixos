{ config, pkgs, ... }:

{
  ##########################################################################
  # Core user information – required by Home Manager
  ##########################################################################
  home.username      = "charlie";
  home.homeDirectory = "/home/charlie";

  ##########################################################################
  # General Home‑Manager settings
  ##########################################################################
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";   # Must match the NixOS stateVersion

}

