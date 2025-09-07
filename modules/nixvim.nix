{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    options = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };

    colorscheme = "gruvbox";

    plugins = {
      treesitter.enable = true;
      telescope.enable = true;
      lualine.enable = true;

      # LSP + completion
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          pyright.enable = true;
          rust_analyzer.enable = true;
        };
      };

      cmp = {
        enable = true;
        sources = [ "nvim_lsp" "buffer" "path" "luasnip" ];
      };

      luasnip.enable = true;
    };
  };
}

