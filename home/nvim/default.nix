
{ config, pkgs, inputs, ... }:

let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: ''
    lua << EOF
    ${builtins.readFile file}
    EOF
  '';
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      bash-language-server
      ghostscript
      gopls
      lazygit
      ltex-ls
      lua-language-server
      marksman
      marp-cli
      nixd
      nixpkgs-fmt
      nodejs
      pandoc
      python313Packages.python-lsp-server
      sqlite
      texliveSmall
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
      yamllint
    ];

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
        plugin = nvim-treesitter.withAllGrammars {};
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
      ${toLuaFile ./autocmds.lua}
      ${toLuaFile ./options.lua}
      ${toLuaFile ./productivity.lua}
    '';
  };
}

