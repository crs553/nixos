{ config, pkgs, ... }:

{
  ##########################################################################
  # Core user information – required by Home Manager
  ##########################################################################
  home.username      = "charlie";
  home.homeDirectory = "/home/charlie";

  ##########################################################################
  # General Home‑Manager settings
  ##########################################################################
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";   # Must match the NixOS stateVersion

  ##########################################################################
  # Nixvim (Neovim) configuration
  ##########################################################################
  # The heavy‑lifting lives in ./nixvim/default.nix – we just import it
  # here so that Home Manager knows to enable the module and apply the
  # settings you define in that file.
  programs.nixvim = {
    enable = true;

    # Import the detailed configuration from a sibling file.
    # The path is relative to this `home.nix`.
    # Anything you export from `nixvim/default.nix` (opts, plugins,
    # extraConfig, etc.) will be merged here.
    imports = [ ./nixvim/default.nix ];
  };

  ##########################################################################
  # (Optional) Additional Home‑Manager services you might want
  ##########################################################################
  # Example – enable a terminal emulator, a shell, etc.
  # programs.zsh.enable = true;
  # services.gpg-agent.enable = true;
}

