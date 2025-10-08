{
  config,
  lib,
  pkgs,
  unstablePkgs,
  ...
}:

with lib;

let
  cfg = config.docker;
in
{
  options.docker = {
    enableDocker = mkEnableOption "Enable Docker";
  };

  config = mkIf cfg.enableDocker {
    virtualisation.docker.enable = true;
    users.users.charlie.extraGroups = [ "docker" ];
  };
}
