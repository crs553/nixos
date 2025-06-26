{
  description = "My NixOS general work configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixos-unstable, ... }:
    let
      system = "x86_64-linux";
      defaultHost = "workstation";

      modulesDir = ./modules;

      mkHost = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostName}/configuration.nix
          /etc/nixos/luks.nix
          "${modulesDir}/common.nix"
          "${modulesDir}/desktop.nix"

          # global system version
          { system.stateVersion = "25.05"; }
        ];
        specialArgs = {
          unstablePkgs = import nixos-unstable { inherit system; config.allowUnfree = true;};
        };
      };
    in {
      nixosConfigurations = {
        laptop = mkHost "laptop";
        workstation = mkHost "workstation";
      };

      defaultPackage.${system} =
        self.nixosConfigurations.${defaultHost}.config.system.build.toplevel;
    };
}

