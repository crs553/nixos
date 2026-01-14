{ config, pkgs, inputs, ... }:

{
  imports = [
    ./bat
    ./dunst
    ./firefox
    ./fzf
    ./git
    ./kitty
    ./mpv
    ./nvim
    ./pandoc
    ./starship
    ./tmux
    ./waybar
    ./wofi
    ./zoxide
    ./zsh
  ];

  home.username = "charlie";
  home.homeDirectory = "/home/charlie";
  home.stateVersion = "25.11";

  home.activation.commands = [
    "gsettings set org.nemo.preferences show-recent false"
  ];

  programs.home-manager.enable = true;

  programs.btop.enable = true;

  # Add packages to your user environment
  home.packages = with pkgs; [

    fastfetch

    # Neovim dashboard
    cowsay
    fortune

    # Browser
    mullvad-browser


    # utils
    wget
    ripgrep
    rsync
    fd
    dysk
    gcc
    gnumake
    libnotify # for notify send
    
    # Markdown / Documentation
    marp-cli
    texliveSmall
    zathura

    # archives
    unzip
    zip

    
    # Media
    vlc
    feh
    makemkv
    handbrake
    ffmpeg
    mat2
    gimp3-with-plugins
    obs-studio

    # Files
    localsend
    
    # Communication
    signal-desktop

    # Teaching
    openboard

    # Coding
    bruno
    bruno-cli
    onlyoffice-desktopeditors
    libreoffice
    qbittorrent

    (python3.withPackages (python-pkgs: with python-pkgs; [
      pandas
      requests
      python-lsp-server
      black
      isort
      pylint
      mypy
      pip
      textual
      pylatexenc
      httpx

    ]))


  ];
}

