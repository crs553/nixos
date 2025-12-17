{ config, pkgs, inputs, ... }:
{

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

