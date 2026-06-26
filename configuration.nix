{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";

  services.displayManager.ly.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };

  services.gvfs.enable = true;

  users.users.floki = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video"];
    packages = with pkgs; [
      tree
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # dconf
  programs.dconf.enable = true;

  programs.firefox.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.sessionVariables = {
    ZDOTDIR = "$HOME/.config/zsh";
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adw-gtk3
    alejandra
    awww
    bat
    btop
    eza
    fzf
    gcc
    geany
    git
    gnome-themes-extra
    hypridle
    hyprlock
    hyprshot
    hunspell
    hunspellDicts.en_US
    kitty
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    libnotify
    libreoffice-fresh
    lua-language-server
    neovim
    nitch
    nil
    nwg-look
    p7zip
    papirus-icon-theme
    pamixer
    pavucontrol
    pcmanfm
    pywal16
    pywalfox-native
    quickshell
    rofi
    swaynotificationcenter
    tokyonight-gtk-theme
    unzip
    vlc
    vscode-fhs
    waypaper
    wget
    xdg-user-dirs
    xdg-user-dirs-gtk
    yazi
    zoxide
  ];

  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
    nerd-fonts.geist-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
