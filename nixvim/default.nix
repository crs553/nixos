# nixvim/default.nix
{ pkgs, ... }:

{
  ##########################################################################
  # Core Neovim options
  ##########################################################################
  opts = {
    number          = true;   # show absolute line numbers
    relativenumber  = true;   # show relative numbers
    mouse           = "a";    # enable mouse support
    clipboard       = "unnamedplus";
    expandtab       = true;
    shiftwidth      = 2;
    tabstop         = 2;
  };

  ##########################################################################
  # Plugins – pulled from the nixpkgs `vimPlugins` collection
  ##########################################################################
  plugins = with pkgs.vimPlugins; [
    vim-nix                # Nix syntax highlighting
    nvim-treesitter        # Better syntax parsing
    telescope-nvim         # Fuzzy finder
    nvim-lspconfig         # LSP client framework
    which-key-nvim         # Popup key hints
    gruvbox                # Colorscheme (swap for any you like)
    lualine-nvim           # Status line
  ];

  ##########################################################################
  # Extra raw configuration (Lua / Vimscript)
  ##########################################################################
  extraConfig = ''
    lua << EOF
    -- Example: start the Nix language server (nil)
    require('lspconfig').nil_ls.setup{}
    EOF
  '';
}
