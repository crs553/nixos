# nixvim.nix
{ config, pkgs, ... }:

{
  ##########################################################################
  # ENABLE nixvim
  ##########################################################################
  programs.nixvim.enable = true;

  ##########################################################################
  # OPTIONAL: make Neovim the default editor for the user
  ##########################################################################
  programs.nixvim.defaultEditor = true;

  ##########################################################################
  # CORE Neovim options (equivalent to `:set` commands)
  ##########################################################################
  programs.nixvim.opts = {
    number          = true;          # absolute line numbers
    relativenumber  = true;          # relative numbers
    mouse           = "a";           # mouse support
    termguicolors   = true;          # needed for most colour schemes
  };

  ##########################################################################
  # Clipboard configuration
  ##########################################################################
  programs.nixvim.clipboard.register = "unnamedplus";

  ##########################################################################
  # COLOURSCHEME – Catppuccin (you can swap this for any other)
  ##########################################################################
  programs.nixvim.colorschemes.catppuccin.enable = true;

  ##########################################################################
  # PLUGINS (optional – add whatever you like)
  ##########################################################################
  # Uncomment / edit the block below if you want plugins.
  # programs.nixvim.plugins = with pkgs.vimPlugins; [
  #   vim-nix
  #   nvim-treesitter
  #   telescope-nvim
  #   which-key-nvim
  #   catppuccin-nvim   # Catppuccin theme plugin (if you want the plugin too)
  # ];

  ##########################################################################
  # EXTRA LUA / VIMSCRIPT (optional)
  ##########################################################################
  # programs.nixvim.extraConfig = ''
  #   lua << EOF
  #   -- Example: start the Nix language server (nil)
  #   require('lspconfig').nil_ls.setup{}
  #   EOF
  # '';
}
