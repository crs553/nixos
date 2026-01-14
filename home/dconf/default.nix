{ pkgs, config, ... }:
{
  # dconf settings
  programs.dconf.settings = {
    # Hide "Recent" in Nemo
    "org/nemo/preferences" = {
      show-recent = false;
    };

    # GNOME dark theme
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
