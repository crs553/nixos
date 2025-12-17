{ config, pkgs, inputs, ... }:
{

  programs.zsh = {
    enable = true;
    enableCompletions = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
    };
    history.size = 10000;
  };
}
