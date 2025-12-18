{ config, pkgs, ... }:

let
  catppuccinKitty = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "kitty";
    rev = "b14e8385c827f2d41660b71c7fec1e92bdcf2676";
    # Pin to that commit for reproducibility
    sha256 = "59ON7CzVgfZUo7F81qQZQ1r6kpcjR3OPvTl99gzDP8E=";
  };

  mochaTheme = "${catppuccinKitty}/themes/mocha.conf";
in
{
  # Set TERM
  home.sessionVariables.TERM = "xterm-256color";

  programs.kitty = {
    enable = true;

    # Load the theme from the pinned commit
    extraConfig = builtins.readFile mochaTheme;
  };
}

