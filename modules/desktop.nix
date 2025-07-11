{config, pkgs, ...}:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  #services.displayManager.defaultSession = "hyprland";
  services.displayManager.defaultSession = "hyprland-uwsm";


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.waybar = {
    enable = true;
    systemd.target = "hyprland-session.target";
  };

  # dark mode
  environment.variables.GTK_THEME = "Adwaita:dark";

  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];
  
  networking.networkmanager.enable=true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    kitty # needed on isntall
    wezterm

    brightnessctl
    dunst
    swaylock

    # for screenshots
    grim
    slurp

    # Volume and audio
    pavucontrol

    # Sys tray
    networkmanagerapplet

    # filesystem
    nautilus
    udisks2
    polkit_gnome
    gnome-disk-utility

    wofi
    bemenu
    dconf

    hyprpaper

    wl-clipboard
    ];
  }
