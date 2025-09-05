{ config, pkgs, ... }:

{
  home.username = "charlie";
  home.homeDirectory = "/home/charlie";

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      catppuccin-nvim
      friendly-snippets
      harpoon2
      lualine-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      oil-nvim
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      vim-fugitive
    ];

    /*--extraLuaConfig = ''
    --    -- your init.lua contents
    --    ${builtins.readFile ./nvim/init.lua}
    --'';*/
  };

  home.packages = with pkgs; [
    cargo
    rustc
  ];

  home.stateVersion = "25.05"; # match your NixOS version
}

