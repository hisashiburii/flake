# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "quack"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hisa = {
    isNormalUser = true;
    description = "hisashiburi";
    extraGroups = ["networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # vesktop...
  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;
  };

  # god i love packages they are so sexy and amazing
  environment.systemPackages = with pkgs; [
    vim
    firefox
    spotify
    sptlrx
    playerctl
    pavucontrol
    prismlauncher
    fuzzel
    neovim
    grim
    slurp
    git
    gh
    gcc
    hyfetch
    libnotify
    kitty
    grimblast
    wlogout
    swaybg
    gimp
    python3
    piper
    libratbag
    feh
    exfat
    htop
    heroic
    libsForQt5.ark
    qbittorrent
    nitch
    (pkgs.callPackage ./catppuccin-sddm.nix {})
    (discord.override {withVencord = true;})
  ];

  fonts.packages = with pkgs; [
    iosevka
    jetbrains-mono
    font-awesome
    (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono"];})
  ];

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };
  hardware.opengl.driSupport32Bit = true;

  # flatpak
  services.flatpak.enable = true;

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

  # enable nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # enable sddm
  services.xserver.displayManager.sddm.enable = true;
  # and xserver
  services.xserver.enable = true;
  # enable hyprland
  programs.hyprland.enable = true;
  # ..and waybar too
  programs.waybar.enable = true;

  # Enable Thunar here because its dumb and doesnt like to be with the other packages.
  programs.thunar.enable = true;
  services.gvfs.enable = true; # mount trash etc
  services.tumbler.enable = true; # thumbnail support for images.
  
  # Enable NTFS to see Windows on file managers
  boot.supportedFilesystems = [ "ntfs" ];
  # Needed for much other things but its here mainly cause i need it to get into my windows drive 
  security.polkit.enable = true;

  # Enable gtk portal for flameshot and other gtk apps
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # finallyu the gtk portal
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Enable Fish Shell
  programs.fish.enable = true;

  # Insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
  ];

  services.xserver.displayManager.sddm.theme = "catppuccin-mocha";

  system.stateVersion = "23.05"; # alot of yip yap about changing this just read the man config whatever
}
