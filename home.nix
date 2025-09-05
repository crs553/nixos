{ config, pkgs,inputs, ... }:
{
  home.username      = "charlie";
  home.homeDirectory = "/home/charlie";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";   # Must match the NixOS stateVersion

  imports = [
    inputs.nixvim.homeModules.nixvim
    "./nixvim/default.nix"
  ];
}

