{ config, pkgs, ... }:
{

  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11"; # Must match the NixOS stateVersion

  programs.home-manager.enable = true;
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile
  in
  {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      catppuccin-nvim
      mini-nvim
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }
    ];
   extraLuaConfig = ''
     ${builtins.readFile ./nvim/init.lua}
   '';
  };

}
