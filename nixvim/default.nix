# nixvim.nix
{ config, pkgs, ... }:

{
  programs.nixvim.enable = true;

  programs.nixvim.defaultEditor = true;

  programs.nixvim.opts = {
    number          = true;          # absolute line numbers
    relativenumber  = true;          # relative numbers
    mouse           = "a";           # mouse support
    termguicolors   = true;          # needed for most colour schemes
  };

  programs.nixvim.clipboard.register = "unnamedplus";

  programs.nixvim.colorschemes.catppuccin.settings = {
    enable = true;
    flavour = "mocha";

    transparentBackground = false;

    styles = {
      comments    = [ "italic" ];
      conditionals = [ "italic" ];
    };

    # --------------------------------------------------------------------
    # Integrations – enable Tree‑sitter and native LSP support
    # --------------------------------------------------------------------
    integrations = {
      cmp = true;
      treesitter = true;
      native_lsp = {
        enabled = true;
      };
    };

    # --------------------------------------------------------------------
    # Custom highlight overrides – exactly the three groups you listed
    # --------------------------------------------------------------------
    #customHighlights = colors: {
    #  LineNr       = { fg = colors.overlay1; };
    #  CursorLineNr = {
    #    fg    = colors.pink;
    #    style = [ "bold" ];
    #  };
    #  CursorLine   = { bg = colors.surface0; };
    #};
  };
  

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
