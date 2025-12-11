{ config, pkgs, ... }:
{

  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11"; # Must match the NixOS stateVersion

  programs.home-manager.enable = true;
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
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
    ];
   extraLuaConfig = ''
     ${builtins.readFile ./nvim/options.lua}
   '';
  };

}
