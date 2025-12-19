# NixOS Multi-Host Flake Configuration

Repository for my single flake-based configuration across multiple-systems

## General Project Structure

```text
.
├── flake.nix                      # Flake entry point
├── hosts/
│   ├── laptop/
│   │   ├── configuration.nix     # Host-specific config
│   │   └── hardware-configuration.nix
│   └── workstation/
│       ├── configuration.nix
│       └── hardware-configuration.nix
└── home/
└── modules/
    ├── common.nix                # Shared config (locale, users, packages)
    ├── desktop.nix               # Shared desktop setup
    └── luks.nix                  # Shared LUKS setup
````

---

## Getting Started

Clone the repo:

```sh
git clone https://github.com/crs553/nixos
cd nixos-flake
```

### Rebuild system for a host

Replace `workstation` with your hostname as needed:

I use impure right now as I haven not yet setup secretes.

```sh
sudo nixos-rebuild switch --flake .#workstation --impure
```

### Build the system without switching:

```sh
nix build .#nixosConfigurations.workstation.config.system.build.toplevel
```

---

## Example: `modules/luks.nix`

You should move your LUKS setup from host configs into this shared module. Example:

```nix
{ config, lib, pkgs, ... }:

{
  boot.initrd.luks.devices."luks-root" = {
    device = "/dev/disk/by-uuid/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX";
    preLVM = true;
  };
}
```

> Each host can override the UUID in its own config if needed.

---

## Example: `hosts/workstation/hardware-configuration.nix`

This file is **generated** by the `nixos-generate-config` tool and is hardware-specific.

> This is necessary for booting. If you're publishing this repo publicly, consider `.gitignore`-ing or sanitizing UUIDs.
