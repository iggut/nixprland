{ pkgs, inputs, ...}: let

  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );

  in {
  programs = {
    firefox.enable = false; # Firefox is not installed by defualt
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = true;
    mtr.enable = true;
    adb.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
		    exo
		    mousepad
		    thunar-archive-plugin
		    thunar-volman
		    tumbler
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = (with pkgs; [
    # --- Terminal Utilities ---
    amfora             # Fancy Terminal Browser For Gemini Protocol
    cmatrix            # Matrix Movie Effect In Terminal
    cowsay             # Great Fun Terminal Program
    duf                # Utility For Viewing Disk Usage In Terminal
    eza                # Beautiful ls Replacement
    htop               # Terminal Based System Monitor
    ncdu               # Disk Usage Analyzer (TUI)
    ripgrep            # Fast Text Search Tool
    vim                # Terminal Text Editor
    kitty              # GPU-Accelerated Terminal Emulator

    # --- System Management ---
    bc                 # Arbitrary Precision Calculator
    btrfs-progs        # Btrfs Filesystem Utilities
    brightnessctl      # Screen Brightness Control
    clang              # C/C++ Compiler Toolchain
    cpufrequtils       # CPU Frequency Tuning
    libvirt            # Virtualization Toolkit
    lm_sensors         # Hardware Monitoring Sensors
    lshw               # Hardware Information Tool
    pciutils           # PCI Bus Utilities
    virt-viewer        # Graphical VM Console Viewer

    # --- Multimedia & Audio/Video ---
    ffmpeg             # Video/Audio Processing Toolkit
    imv                # Image Viewer for Wayland
    mpv                # Versatile Media Player
    pavucontrol        # PulseAudio Volume Control
    playerctl          # Media Player Control
    yt-dlp             # YouTube Video Downloader
    ytmdl              # YouTube Music Downloader
    imagemagick        # CLI Image Manipulation Toolkit
    pamixer            # PulseAudio CLI Mixer

    # --- Graphical Applications ---
    brave              # Privacy-Focused Browser
    gedit              # Simple Graphical Text Editor
    gimp               # Advanced Image Editor
    loupe              # GNOME Image Viewer
    picard             # Music Tag Editor
    baobab             # Disk Usage Analyzer (GUI)
    yad                # GTK Dialog Box Generator

    # --- Development Tools ---
    docker-compose     # Docker Container Orchestration
    git                # Version Control System
    meson              # Build System Generator
    ninja              # High-Performance Build System
    pkg-config         # Library Compilation Helper
    nixfmt-rfc-style   # Nix Code Formatter (RFC-style)
    jq                 # JSON Processor/Formatter

    # --- Hyprland Ecosystem ---
    #ags_1              # Desktop Overview (AGS)
    cava               # Audio Spectrum Visualizer
    cliphist           # Clipboard History Manager
    hypridle           # Idle Management Daemon
    hyprpicker         # Color Picker Tool
    nwg-displays       # Display Configuration Tool
    pyprland           # Hyprland Python Utilities
    rofi-wayland       # Application Launcher
    swaynotificationcenter # Notification Center
    swww               # Animated Wallpaper Engine

    # --- System Configuration ---
    greetd.tuigreet    # TUI Login Manager
    gtk-engine-murrine # GTK Theme Engine
    libsForQt5.qt5ct  # Qt5 Configuration Tool
    qt6ct  # Qt6 Configuration Tool
    libsForQt5.qtstyleplugin-kvantum # Kvantum Theme Engine
    nwg-look           # GTK Theme Switcher
    wallust            # Wallpaper Color Generator
    glib               # Required for gsettings Integration
    gsettings-qt       # Qt-GSettings Integration
    kdePackages.qtwayland # Qt Wayland Platform Integration

    # --- System Monitoring ---
    btop               # Advanced System Monitor
    gnome-system-monitor # GUI System Monitor
    nvtopPackages.full # GPU Monitoring Tool

    # --- Clipboard/Screenshot ---
    grim               # Screenshot Tool (Wayland)
    slurp              # Region Selector
    swappy             # Screenshot Editor
    wl-clipboard       # Wayland Clipboard Utilities

    # --- System Services ---
    libappindicator    # Application Indicators
    libnotify          # Desktop Notifications
    lxqt.lxqt-policykit # PolicyKit Agent
    openssl            # Cryptography Library
    polkit_gnome       # Authentication Agent

    # --- Archive Utilities ---
    appimage-run       # AppImage Runtime
    file-roller        # Archive Manager
    unrar              # RAR Archive Extractor
    unzip              # ZIP Archive Extractor
    xarchiver          # Lightweight Archive Manager

    # --- Hardware Utilities ---
    socat              # Multipurpose Relay
    usbutils           # USB Device Tools
    v4l-utils          # Video4Linux Utilities

    # --- Miscellaneous ---
    killall            # Process Termination Tool
    lolcat             # Colorful Terminal Output
    xdg-user-dirs      # Standard User Directories
    xdg-utils          # Desktop Integration Tools
    wlogout            # Wayland Logout Menu
  ]) ++ [
	  python-packages
  ];
}
