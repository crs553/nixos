# /etc/nixos/flake.nix
{
  description = "My NixOS general work configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
   let
      system = "x86_64-linux";  # or "aarch64-linux" for ARM
      defaultHost = "workstation";  # Change this to switch which host is "default"

      # helper function to get module paths inside flake
      modulesDir = ./modules;

      mkHost = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
	modules = [
          ./hosts/${hostName}/configuration.nix
          ./luks-symlink.nix
          "${modulesDir}/common.nix"
          "${modulesDir}/desktop.nix"

	  # global system version
	  { system.stateVersion ="25.05"; }
          ];
      };
    in {
      nixosConfigurations = {
        laptop = mkHost "laptop";
        workstation = mkHost "workstation";
      };

      # Optional: set default build target for `nixos-rebuild build --flake .#`
      defaultPackage.${system} = self.nixosConfigurations.${defaultHost}.config.system.build.toplevel;
    };
  #{

  #  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
  #    # NOTE: Change this to aarch64-linux if you are on ARM
  #    modules = [ ./configuration.nix ];
  #  };
  #};
}

