{
  description = "My NixOS general work configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Add nix-flatpak from unstable branch (optionally pin it)
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # Home manager
    home-manager = {
        url = "github:nix-community/home-manager/release-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim plugin
    nixvim = {
        # url = "github:nix-community/nixvim";
        # If using a stable channel you can use:
        url = "github:nix-community/nixvim/nixos-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-unstable, nix-flatpak, nixvim, home-manager, ... }:
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
          nixvim.nixosModules.nixvim
          "${modulesDir}/nixvim.nix"
          

          # Include nix-flatpak module
          nix-flatpak.nixosModules.nix-flatpak

	  # Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {inherit inputs;};
            # Per‑user Home Manager configuration
            home-manager.users.charlie = import ./home.nix;
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
      homeConfigurations.charlie = home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
        modules = [
          ./home.nix
        ];
      };


      defaultPackage.${system} =
        self.nixosConfigurations.${defaultHost}.config.system.build.toplevel;
    };
}
