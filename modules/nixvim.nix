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
	enableTelescope = false;
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
      
      globals = {
        localleader = " ";
	mapleader = " ";
      };
      opts = {
	      number          = true;                     # absolute line numbers
	      relativenumber  = true;                     # relative to the cursor
	      clipboard       = "unnamedplus";            # use system clipboard for all ops
	      syntax          = "on";                     # enable syntax highlighting
	      autoindent      = true;                     # copy indent from current line
	      expandtab       = true;                     # insert spaces instead of tabs
	      shiftwidth      = 4;                        # spaces per indent step
	      tabstop         = 4;                        # visual width of a tab character
	      cursorline      = true;                     # highlight the line the cursor is on
	      ruler           = true;                     # show line & col in the status line
	      title           = true;                     # set window title from 'titlestring'
	      hidden          = true;                     # allow abandoning buffers without saving
	      wildmenu        = true;                     # enhanced command‑line completion UI
	      showcmd         = true;                     # echo partial commands in the last line
	      showmatch       = true;                     # briefly jump to matching bracket
	      inccommand      = "split";                  # preview :substitute etc. in a split
	      wrap            = true;                     # wrap long lines visually
      };

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
	  action  = "function() require('toggleterm').toggle() end";
	  options = { noremap = true; silent = true; };
	}
	{
	  mode    = "t";
	  key     = "<M-i>";
	  action  = "function() require('toggleterm').toggle() end";
	  options = { noremap = true; silent = true; };
	}
      
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
