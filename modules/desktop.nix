{config, pkgs, ...}:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.waybar.enable = true;

  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];
  
  networking.networkmanager.enable=true;

  environment.systemPackages = with pkgs; [
    kitty # needed on isntall

    brightnessctl
    dunst
    swaylock

    # for screenshots
    grim
    slurp

    # Volume and audio
    pavucontrol

    # filesystem
    nautilus

    wofi
    dconf

    hyprpaper

    wl-clipboard
    ];
  }
