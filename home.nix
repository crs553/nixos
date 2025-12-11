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
        config = toLuaFile ./nvim/plugins/lsp.lua;
      }

      {
        plugin = catppuccin-nvim;
        config = toLuaFile ./nvim/plugins/catppuccin.lua;
      }
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugins/cmp.lua;
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
        plugin = mini-icons;
        config = toLua "require(\"mini.icons\").setup()";
      }

      {
        plugin = oil-nvim;
        config = toLuaFile ./nvim/plugins/oil.lua;
      }

      {
        plugin = snacks-nvim;
        config = toLuaFile ./nvim/plugins/snacks.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugins/telescope.lua;
      }

      telescope-fzf-native-nvim
      {
        plugin = vim-floaterm;
        config = toLuaFile ./nvim/plugins/floaterm.lua;
      }

      {
        plugin = which-key-nvim;
        config = toLuaFile ./nvim/plugins/which-key.lua;

      }
    ];

    extraConfig = ''
      ${toLuaFile ./nvim/options.lua}
      ${toLuaFile ./nvim/autocmds.lua}
    '';
  };
}

