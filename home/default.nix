{ config, pkgs, ... }:

let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: ''
    lua << EOF
    ${builtins.readFile file}
    EOF
  '';

  neovimModule = import ./nvim/init.nix {
    inherit pkgs toLua toLuaFile;
  };

in
{
  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  programs.btop.enable = true;

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
      nodejs # needed for vscode lang servers
      pandoc
      python313Packages.python-lsp-server
      sqlite
      texliveSmall
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server

      yamllint
    ];

    inherit (neovimModule) plugins extraConfig;
  };
}

