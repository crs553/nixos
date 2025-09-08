{ config, pkgs,inputs, ... }:
{
  useGlobalPkgs = true;
  useUserPackages = true;
  backupFileExtension = "backup";

  home.username      = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.05";   # Must match the NixOS stateVersion

  programs.home-manager.enable = true;
  programs.nixvim.enable = true;
  users.charlie.imports = [
    inputs.nixvim.homeModules.nixvim
  ]

}

