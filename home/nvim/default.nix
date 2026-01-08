
{ config, pkgs, inputs, ... }:

let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: ''
    lua << EOF
    ${builtins.readFile file}
    EOF
  '';

  py = pkgs.python313Packages;
in

  {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # Language servers
      bash-language-server
      gopls
      ltex-ls
      lua-language-server
      marksman
      nixd
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server

      # Dev / tooling
      lazygit
      nixpkgs-fmt
      nodejs
      yamllint

      # Docs / publishing
      ghostscript
      marp-cli
      pandoc
      texliveSmall

      # Database
      sqlite

      (python3.withPackages (python-pkgs: with python-pkgs; [
        pandas
        requests
        python-lsp-server
        black
        isort
        pylint
        mypy
        pip
        textual
        pylatexenc
        httpx

      ]))
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
        plugin = nvim-treesitter.withAllGrammars;
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

