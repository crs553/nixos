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
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];

  ##########################################################################
  ## 3️⃣ Only evaluate the body when the user actually enables it
  ##########################################################################
  config = lib.mkIf config.nixvim.enable {
    ######################################################################
    ## 4️⃣ Minimal Neovim configuration – same on every host
    ######################################################################
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin.enable = true;
      plugins.lualine.enable = true;
      plugins.oil.enable = true;
      plugins.smear.enable = true;
    };
  };
}
