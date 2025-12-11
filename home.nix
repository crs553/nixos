{ config, pkgs, ... }:

let
  toLuaFile = file: ''
    lua << EOF
    ${builtins.readFile file}
    EOF
  '';
in
{
  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = catppuccin-nvim;
        config = toLuaFile ./nvim/plugins/catppuccin.lua;
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugins/treesitter.lua;
      }
      
      {
        plugin = oil-nvim;
        config = toLuaFile ./nvim/plugins/oil.lua;
      }

      {
        plugin = mini-icons-nvim;
        config = "require('mini.icons').setup({})";
      }
    ];

    extraConfig = ''
      ${toLuaFile ./nvim/options.lua}
    '';
  };
}

