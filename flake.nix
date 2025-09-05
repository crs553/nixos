
{
  description = "My NixOS general work configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Add nix-flatpak from unstable branch (optionally pin it)
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # Home manager
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-unstable, nix-flatpak, ... }:
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
          "${modulesDir}/devtools.nix"
          "${modulesDir}/gaming.nix"

          # Include nix-flatpak module
          nix-flatpak.nixosModules.nix-flatpak
          
          # Integrate Home Manager as a NixOS module
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;

            # Define user configs here (points to home.nix)
            home-manager.users.myuser = import ./home.nix;
          }

          # global system version
          { system.stateVersion = "25.05"; }
        ];

        specialArgs = {
          unstablePkgs = import nixos-unstable {
            inherit system;
            config.allowUnfree = true;
          };
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

