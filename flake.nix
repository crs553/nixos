
{
  description = "My NixOS general work configuration";

  # ----------------------------------------------------------------------
  # INPUTS
  # ----------------------------------------------------------------------
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Unstable channel – used for packages that are not in the stable set
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Flatpak helper
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # Home Manager (release matching the stable channel)
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS hardware modules
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  # ----------------------------------------------------------------------
  # OUTPUTS
  # ----------------------------------------------------------------------
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-unstable,
      nix-flatpak,
      home-manager,
      nixos-hardware,
      ...
    }:
    let
      system = "x86_64-linux";
      defaultHost = "workstation";

      # Directory that holds the reusable modules
      modulesDir = ./modules;

      # ------------------------------------------------------------------
      # Helper to build a host configuration
      # ------------------------------------------------------------------
      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [

            # Host‑specific configuration
            ./hosts/${hostName}/configuration.nix

            # Framework Laptop hardware module (only for laptop)
            (if hostName == "laptop" then
              nixos-hardware.nixosModules.framework-12th-gen-intel
            else null)

            # Global modules
            /etc/nixos/luks.nix
            "${modulesDir}/common.nix"
            "${modulesDir}/desktop.nix"
            "${modulesDir}/devtools.nix"
            "${modulesDir}/gaming.nix"
            #"${modulesDir}/nixvim.nix"
            "${modulesDir}/docker.nix"

            # Flatpak support
            nix-flatpak.nixosModules.nix-flatpak

            # Home Manager as a NixOS module
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.charlie = import ./home;
            }

            # Global system version
            { system.stateVersion = "25.11"; }
          ];

          # ----------------------------------------------------------------
          # Special arguments that are visible to *all* modules
          # ----------------------------------------------------------------
          specialArgs = {

            # Provide the unstable package set for any module that wants it.
            unstablePkgs = import nixos-unstable {
              inherit system;
              config.allowUnfree = true;
            };

            inherit inputs;
          };
        };
    in
    {
      # ------------------------------------------------------------------
      # NixOS configurations (machines)
      # ------------------------------------------------------------------
      nixosConfigurations = {
        laptop = mkHost "laptop";
        workstation = mkHost "workstation";
        pocket = mkHost "pocket";
      };

      # ------------------------------------------------------------------
      # Home‑Manager configuration (per‑user)
      # ------------------------------------------------------------------
      homeConfigurations.charlie = home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
        modules = [ ./home.nix ];
      };

      # ------------------------------------------------------------------
      # Default package (so `nix build .#` works)
      # ------------------------------------------------------------------
      defaultPackage.${system} = self.nixosConfigurations.${defaultHost}.config.system.build.toplevel;
    };
}

