{ pkgs, toLua, toLuaFile, ... }:

{
  plugins = with pkgs.vimPlugins; [

    
    {
      plugin = nvim-lspconfig;
      config = toLuaFile ./plugins/lsp.lua;
    }
    {
      plugin = catppuccin-nvim;
      config = toLuaFile ./plugins/catppuccin.lua;
    }

    {
      plugin = nvim-cmp;
      config = toLuaFile ./plugins/cmp.lua;
    }
    cmp-nvim-lsp
    luasnip

    {
      plugin = (nvim-treesitter.withAllGrammars);
      config = toLuaFile ./plugins/treesitter.lua;
    }

    {
      plugin = mini-icons;
      config = toLua "require('mini.icons').setup()";
    }

    {
      plugin = oil-nvim;
      config = toLuaFile ./plugins/oil.lua;
    }

    {
      plugin = snacks-nvim;
      config = toLuaFile ./plugins/snacks.lua;
    }

    {
      plugin = telescope-nvim;
      config = toLuaFile ./plugins/telescope.lua;
    }

    telescope-fzf-native-nvim

    {
      plugin = vim-floaterm;
      config = toLuaFile ./plugins/floaterm.lua;
    }

    {
      plugin = which-key-nvim;
      config = toLuaFile ./plugins/which-key.lua;
    }
  ];

  extraConfig = ''
    ${toLuaFile ./options.lua}
    ${toLuaFile ./autocmds.lua}
  '';
}

