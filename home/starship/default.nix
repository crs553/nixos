{ config, pkgs, inputs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
