{
  config,
  lib,
  pkgs,
  unstablePkgs,
  ...
}:

with lib;

let
  cfg = config.devtools; # Changed from lsp to devtools
in
{
  options.devtools = {
    # Changed from lsp to devtools
    # enableGit = mkEnableOption "Enable Git devtools";
    enableBash = mkEnableOption "Enable Bash devtools";
    #enablePython = mkEnableOption "Enable Python tools (pylsp, pylint, black, python)";
    enableGo = mkEnableOption "Enable Go devtools (gopls)";
    enableLua = mkEnableOption "Enable Lua devtools";
    enableRust = mkEnableOption "Enable Rust tools (rust-analyzer, rustup, cargo)";
    enableMarkdown = mkEnableOption "Enable Markdown devtools (marksman, markdownlint)";
    enableHarper = mkEnableOption "Enable HarperDB devtools";
    enableNix = mkEnableOption "Enable Nix devtools (nixd)";
    enableRemoteDesktop = mkEnableOption "Enable remote desktop tools";
  };

  config = {
    environment.systemPackages =
      with pkgs;
      lib.optionals true (
        lib.flatten [

          # Git
          # (optional cfg.enableGit git)

          # Bash
          (optional cfg.enableBash bash-language-server)

          # Python
          #(optional cfg.enablePython ())

          # Go
          (optional cfg.enableGo gopls)
          (optional cfg.enableGo go)

          # Lua
          (optional cfg.enableLua lua-language-server)
          (optional cfg.enableLua lua)
          (optional cfg.enableLua luaPackages.luarocks)

          # Rust
          (optional cfg.enableRust rust-analyzer)
          (optional cfg.enableRust unstablePkgs.rustup)

          # Markdown
          (optional cfg.enableMarkdown marksman)
          (optional cfg.enableMarkdown markdownlint-cli)

          # HarperDB
          (optional cfg.enableHarper harper)

          # Nix
          (optional cfg.enableNix nixd)

        ]
      );
  };
}
