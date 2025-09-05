{ config, pkgs, ... }:

let
  # Use vimPlugins from nixpkgs
  vimPlugins = pkgs.vimPlugins;
in
{
  programs.nixvim = {
    enable = true;

    # Optional: Set Neovim options
    neovimOptions = {
      number = true;           # Show line numbers
      relativenumber = true;   # Relative line numbers
      cursorline = true;       # Highlight current line
      mouse = "a";             # Enable mouse
      clipboard = "unnamedplus"; # Use system clipboard
      tabstop = 4;             # Number of spaces per tab
      shiftwidth = 4;          # Indentation width
      expandtab = true;        # Convert tabs to spaces
    };

    # Plugins to include
    extraPlugins = with vimPlugins; [
      # File explorer
      nvim-tree

      # Fuzzy finder
      telescope-nvim

      # LSP and autocompletion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      # Git integration
      fugitive
      gitsigns

      # Syntax highlighting
      treesitter

      # Themes
      gruvbox
      onedark
    ];

    # Optional: key mappings
    keymaps = {
      normal = {
        ["<leader>ff"] = ":Telescope find_files<CR>";
        ["<leader>fg"] = ":Telescope live_grep<CR>";
        ["<leader>fb"] = ":Telescope buffers<CR>";
        ["<leader>fh"] = ":Telescope help_tags<CR>";
      };
    };
  };
}

