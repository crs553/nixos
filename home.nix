{ config, pkgs, ... }:
{

  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11"; # Must match the NixOS stateVersion

  programs.home-manager.enable = true;

}
