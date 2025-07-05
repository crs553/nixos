{ config, lib, pkgs, unstablePkgs, ... }:

with lib;

let
  cfg = config.gaming;
in {
  options.gaming = {
    enableSteam = mkEnableOption "Enable Steam";
  };

  config = mkIf cfg.enableSteam {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}

