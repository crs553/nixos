{ config, pkgs, inputs, ... }:
{
  programs.git = {
    enable = true;

    userName  = "CS";
    userEmail = "42813301+crs553@users.noreply.github.com";

    aliases = {
      st     = "status";
      co     = "checkout";
      br     = "branch";
      df     = "diff";
      p      = "push";
      pf     = "push --force-with-lease";
      comm   = "commit -m";
      graph  = "log --oneline --graph --decorate --all";
      staash = "stash --all";
      stashl = "stash list";
    };

    extraConfig = {
      push = {
        autoSetupRemote = true;
      };

      init = {
        defaultBranch = "main";
      };

      core = {
        editor = "nvim -f";
      };
    };
  };
}

