{
  config,
  pkgs,
  lib,
  unstablePkgs,
  ...
}:

{
  ##############################################################################
  # Basic system settings
  ##############################################################################

  # Timezone
  time.timeZone = "Europe/London";

  # Locale settings
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

  # Keymaps
  console.keyMap = "uk";
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ##############################################################################
  # Boot & kernel
  ##############################################################################

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "sg" ]; # For MakeMKV
    # Bootloader
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };
    loader.efi.canTouchEfiVariables = true;
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };

  ##############################################################################
  # Networking & firewall
  ##############################################################################

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      53317
    ]; # 53317 for LocalSend
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 53315;
        to = 53318;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  ##############################################################################
  # Users & shells
  ##############################################################################

  environment.pathsToLink = [ "/share/zsh" ]; # for home manager completions

  users.users.charlie = {
    isNormalUser = true;
    description = "charlie";
    home = "/home/charlie";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "cdrom"
    ];
  };

  ##############################################################################
  # System packages
  ##############################################################################

  environment.systemPackages = with pkgs; [
    vulnix
    timeshift
    yazi
    nemo

    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font = "DroidSansM Nerd Font";
      fontSize = "9";
      loginBackground = true;
    })
    # Editors / Dev tools
    nodejs

    # Virtualisation
    unstablePkgs.quickemu
    unstablePkgs.spice-gtk

    # Web
    brave



    # Image and Video Editing
  ];

  ##############################################################################
  # Fonts
  ##############################################################################

  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
  ];

  ##############################################################################
  # Services
  ##############################################################################

  # Printing
  # services.printing.enable = true;

  # Antivirus
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    updater.settings = {
      LogVerbose = true;
    };
    updater.interval = "hourly";
    scanner.enable = true;
    scanner.interval = "*-*-* 04:00:00";
    scanner.scanDirectories = [
      "/home"
      "/var/lib"
      "/tmp"
      "/etc"
      "/var/tmp"
    ];
  };

  # Networking services
  services.resolved.enable = true;

  # quickemu
  services.spice-vdagentd.enable=true;

  # VPNs
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Input devices
  hardware.opentabletdriver.enable = true;

  # Drives
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  # Security
  security.polkit.enable = true;

  ##############################################################################
  # Programs
  ##############################################################################

  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  ##############################################################################
  # Developer tools
  ##############################################################################

  devtools = {
    enableBash = true;
    #enablePython = true;
    enableGo = true;
    enableLua = true;
    enableRust = true;
    enableMarkdown = true;
    enableHarper = true;
    enableNix = true;
  };

  ##############################################################################
  # Virtualisation
  ##############################################################################

  virtualisation.spiceUSBRedirection.enable = true;

  # NFS Share
  
  fileSystems."/mnt/media" = {
    device = "192.168.1.145:/export/media";
    fsType = "nfs";
    options = [
      "nfsvers=3"
      "rw"
      "hard"
      "_netdev"
      "proto=tcp"
    ];
  };

  # Flatpak
  services.flatpak = {
    enable = true;
  };


}
