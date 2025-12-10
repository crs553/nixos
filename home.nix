{ config, pkgs, ... }:
{

  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11"; # Must match the NixOS stateVersion

  programs.home-manager.enable = true;
  programs.neovim = {
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
    ];
   extraLuaConfig = ''
     ${builtins.readFile ./nvim/init.lua}
   '';
  };

}
