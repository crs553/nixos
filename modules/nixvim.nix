{ config, lib, pkgs, inputs, ... }:

let
  mkEnableOption = lib.mkEnableOption;
in
{
  ##########################################################################
  ## 1️⃣ Public switch – turn the whole block on/off
  ##########################################################################
  options.nixvim = {
    enable = mkEnableOption "Enable the minimal NixVim configuration";
  };

  ##########################################################################
  ## 2️⃣ Pull in the upstream NixVim module (the real implementation)
  ##########################################################################
  imports = [ inputs.nixvim.nixosModules.nixvim ];

  ##########################################################################
  ## 3️⃣ Only evaluate the body when the user actually enables it
  ##########################################################################
  config = lib.mkIf config.nixvim.enable {

    ######################################################################
    ## 4️⃣ Minimal Neovim configuration – same on every host
    ######################################################################
    programs.nixvim = {
      enable = true;

      plugins.blink-cmp.enable = true;
      colorschemes.catppuccin.enable = true;
      plugins.harpoon = {
        enable = true;
	settings = {
	  save_on_toggle = true;
          sync_on_ui_close = false;
	};
      };
      plugins.lualine.enable = true;
      plugins.oil.enable = true;
      plugins.smear-cursor.enable = true;
      plugins.toggleterm = {
        enable = true;

        settings = {
          size           = 90;
	  open_mapping   = "";          # empty string disables the default

	  shade_terminals = true;
	  shading_factor  = 2;
	  direction       = "float";
	  float_opts = {
	    border   = "curved";
	    winblend = 3;
	  };
	};
      };

      plugins.fugitive.enable = true;

      extraConfigLuaPre = ''
        -- Set the global (and optional local) leader to a single space.
        vim.g.mapleader = " "
        vim.g.maplocalleader = " "
      '';

      keymaps = [
        # Oil file browser
        {
          mode    = "n";            # normal‑mode
          key     = "-";            # the key you press
          action  = ":Oil<CR>";     # run the Oil command
          options = { noremap = true; silent = true; };
        }
        {
          mode    = "n";            # normal‑mode
          key     = "<leader>pv";            # the key you press
          action  = "<CMD>Oil<CR>";     # run the Oil command
          options = { noremap = true; silent = true; };
        }

	# vim fugitive
	{
	  mode = "n";
	  key = "<leader>gs";
	  action = ":Git<CR>";
	}
	{
	  mode = "n";
	  key = "<leader>gd";
	  action = ":Gvdiffsplit<CR>";
	}


	## toggleterm
	{
		mode    = "n";
		key     = "<M-i>";
		action  = "lua require('toggleterm').toggle()";
		options = { noremap = true; silent = true; };
	}
	{
		mode    = "t";
		key     = "<M-i>";
		action  = "lua require('toggleterm').toggle()";
		options = { noremap = true; silent = true; };
	}
      ]
      ++ import ./nixvim/keymaps/harpoon;
      # ---------------------------------------------------------------
      # Load any existing after/ftplugin/*.lua files from your config
      # ---------------------------------------------------------------
      extraConfigLuaPost = ''
        -- The standard runtimepath already contains $HOME/.config/nvim,
        -- so “after/ftplugin/*.lua” will be found automatically.
        --
        -- This line forces Neovim to source every Lua file that lives
        -- under that directory when it starts up.
        vim.cmd('runtime after/ftplugin/*.lua')
      '';
    };
  };
}
