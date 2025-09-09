# 🧊 NixOS Multi-Host Flake Configuration

This repository provides a **single flake-based configuration**.
It isfor managing multiple NixOS machines, such as a laptop and a workstation,
with shared modules for desktop setup and LUKS encryption.

## 📁 Project Structure

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
└── modules/
    ├── common.nix                # Shared config (locale, users, packages)
    ├── desktop.nix               # Shared desktop setup
    └── luks.nix                  # Shared LUKS setup
````

---

## 🚀 Getting Started

Clone the repo:

```bash
git clone https://github.com/yourusername/nixos-flake.git
cd nixos-flake
```

### ⚙️ Rebuild system for a host

Replace `workstation` with your hostname as needed:

I use impure right now as I haven not yet setup secretes.

```bash
sudo nixos-rebuild switch --flake .#workstation --impure
```

### 🏗️ Build the system without switching:

```bash
nix build .#nixosConfigurations.workstation.config.system.build.toplevel
```

---

## 🔐 Example: `modules/luks.nix`

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

> 💡 Each host can override the UUID in its own config if needed.

---

## 💻 Example: `hosts/workstation/hardware-configuration.nix`

This file is **generated** by the `nixos-generate-config` tool and is hardware-specific.

> This is necessary for booting. If you're publishing this repo publicly, consider `.gitignore`-ing or sanitizing UUIDs.
