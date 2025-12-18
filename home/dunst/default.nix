{ pkgs, config, ... }:

let
  dunstConfig = ./dunstrc; # relative path to the same directory
in
{
  programs.dunst.enable = true;
  programs.dunst.configFile = dunstConfig;
}

