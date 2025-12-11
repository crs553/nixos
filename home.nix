{ config, pkgs, ... }:

let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
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

    extraPackages =  with pkgs; [
      lua-language-server
      nixd
    ];

    plugins = with pkgs.vimPlugins; [
      
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

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
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim
      
      {
        plugin = oil-nvim;
        config = toLuaFile ./nvim/plugins/oil.lua;
      }

      {
        plugin = mini-icons;
        config = toLua "require(\"mini.icons\").setup()";
      }
    ];

    extraConfig = ''
      ${toLuaFile ./nvim/options.lua}
    '';
  };
}

