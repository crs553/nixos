{ config, pkgs, inputs, ... }:
{

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
    history = {
      size = 10000;
      save = 10000;
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

  };
}
