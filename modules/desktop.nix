{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
    package = pkgs.kdePackages.sddm;
  };
  services.displayManager.defaultSession = "hyprland-uwsm";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # dark mode
  environment.variables = {
    GTK_THEME = "Adwaita:dark";
    EDITOR = "nvim";
  };

  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];

  networking.networkmanager.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [

    brightnessctl
    hyprlock
    hyprcursor
    hypridle

    # for screenshots
    grim
    slurp

    # Volume and audio
    pavucontrol

    # Sys tray
    networkmanagerapplet

    # filesystem
    udisks2
    polkit_gnome
    gnome-disk-utility

    tofi
    dconf

    hyprpaper
    hyprpicker

    wl-clipboard
    (catppuccin-sddm.override {
      flavor = "mocha";
    })
  ];
}
