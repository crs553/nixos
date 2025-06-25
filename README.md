Got it! Here's a complete example `README.md` you can place at the root of your NixOS flake repository. It documents the project purpose, structure, how to build/deploy, and what should be in files like `luks.nix` and `hardware-configuration.nix`.

---

## 📘 `README.md`

````markdown
# 🧊 NixOS Multi-Host Flake Configuration

This repository provides a **single flake-based configuration** for managing multiple NixOS machines, such as a laptop and a workstation, with shared modules for desktop setup and LUKS encryption.

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

```bash
sudo nixos-rebuild switch --flake .#workstation
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

---

## ❓ FAQ

### Should I share `hardware-configuration.nix`?

Generally yes — it's necessary for a working system rebuild. But if you’re publishing to GitHub, **remove or redact UUIDs**, or exclude it with `.gitignore`.

### Do I need `home-manager`?

No. This flake is for system configuration only. If you want per-user dotfiles and programs, you can add `home-manager` later.

---

## 📦 Requirements

* Nix >= 2.15 with flakes enabled
* NixOS 25.05 or compatible
* Root access for rebuilds

