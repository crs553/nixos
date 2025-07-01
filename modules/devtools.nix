{ config, lib, pkgs, unstablePkgs, ... }:

with lib;

let
  cfg = config.lsp;
in {
  options.lsp = {
    enableBash = mkEnableOption "Enable Bash LSP";
    enablePython = mkEnableOption "Enable Python tools (pylsp, pylint, black, python)";
    enableGo = mkEnableOption "Enable Go LSP (gopls)";
    enableLua = mkEnableOption "Enable Lua LSP";
    enableRust = mkEnableOption "Enable Rust tools (rust-analyzer, rustup, cargo)";
    enableMarkdown = mkEnableOption "Enable Markdown LSPs (marksman, markdownlint)";
    enableHarper = mkEnableOption "Enable HarperDB LSP";
    enableNix = mkEnableOption "Enable Nix LSP (nixd)";
  };

  config = {
    environment.systemPackages = with pkgs; lib.optionals true (
      lib.flatten [

        # Bash
        (optional cfg.enableBash bash-language-server)

        # Python
        (optional cfg.enablePython python3)
        (optional cfg.enablePython python3Packages.python-lsp-server)
        (optional cfg.enablePython pylint)
        (optional cfg.enablePython black)

        # Go
        (optional cfg.enableGo gopls)

        # Lua
        (optional cfg.enableLua lua-language-server)

        # Rust
        (optional cfg.enableRust rust-analyzer)
        (optional cfg.enableRust unstablePkgs.rustup)
        (optional cfg.enableRust unstablePkgs.cargo)

        # Markdown
        (optional cfg.enableMarkdown marksman)
        (optional cfg.enableMarkdown markdownlint-cli)

        # HarperDB
        (optional cfg.enableHarper harper-ls)

        # Nix
        (optional cfg.enableNix nixd)
      ]
    );
  };
}

