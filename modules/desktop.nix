{config, pkgs, ...}:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  programs.hyprland.enable = true;

  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];
  
  networking.networkmanager.enable=true;

  environment.systemPackages = with pkgs; [
    waybar
    kitty
    wofi
    wl-clipboard
    dconf
    hyprpaper
    ];
  }
