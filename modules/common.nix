{ config, pkgs, lib,unstablePkgs, ... }:

{
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Europe/London";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;


  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";
  # Used for spice usb redirection in quickemu
  virtualisation.spiceUSBRedirection.enable = true;


  ### TAILSCALE ###
  services.resolved.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # ZOXIDE
  programs.zoxide.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;


  fonts.packages = with pkgs; [
      font-awesome
      powerline-fonts
      powerline-symbols
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
  ];

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  services.flatpak.enable = true;

  security.polkit.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  #hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  hardware.opentabletdriver.enable = true;

  # Drives
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Language support
  devtools = {
    enableGit = true;
    enableBash = true;
    enablePython = true;
    enableGo = true;
    enableLua = true;
    enableRust = true;
    enableMarkdown = true;
    enableHarper = true;
    enableNix = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.charlie = {
    isNormalUser = true;
    description = "charlie";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ 
	  vlc
	  mullvad-browser
	  mpv
      feh
      starship
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    wget
    ripgrep
    fzf
    unzip
    dysk
    gcc
    gnumake
    rsync

    bat

    # Editors
    # unstablePkgs.neovim
    nodejs
    tree-sitter
    fd

    # Virtualisation/VMs
    unstablePkgs.quickemu
    unstablePkgs.spice-gtk

    # Teaching
    unstablePkgs.openboard

    # Markdown
    unstablePkgs.marp-cli
    unstablePkgs.pandoc
    unstablePkgs.texliveSmall

    unstablePkgs.signal-desktop
    brave

    unstablePkgs.yt-dlp
    mpv

  ];

  services.flatpak.remotes = [
  {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
  }
  ];

  services.flatpak.packages = [
      { appId = "com.usebruno.Bruno"; origin = "flathub"; }
      { appId = "org.onlyoffice.desktopeditors"; origin = "flathub"; }
      { appId = "org.qbittorrent.qBittorrent"; origin = "flathub"; }
  ];

}
