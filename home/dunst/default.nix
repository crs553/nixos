
{ pkgs, config, ... }:

let
  dunstConfig = ./dunstrc; # relative path to the same directory
in
  {
  services.dunst = {
    enable = true;
    configFile = dunstConfig;
  };
}


