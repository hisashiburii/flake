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
    ./comma.nix
    ./hm.nix
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
    spicetify-cli
    sptlrx
    playerctl
    pavucontrol
    prismlauncher
    fuzzel
    grim
    slurp
    gcc
    hyfetch
    libnotify
    grimblast
    swaybg
    gimp
    python3
    piper
    libratbag
    exfat
    heroic
    libsForQt5.ark
    qbittorrent
    nitch
    neo-cowsay
    vlc
    caprine-bin
    appimage-run
    lutris
    pipes
    cbonsai
    protontricks
    yad
    jdk17
    osu-lazer-bin
    rsync
    parted
    ventoy-full
    hyprpaper
    cinnamon.nemo
    obsidian
    ffmpeg
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

  programs.fish.enable = true;

  hardware.pulseaudio.enable = false;

  # enable nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # enable GNOME and depends (im breaking free)
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # some GNOME shenanigans
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

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

  # Insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
    "electron-25.9.0"
  ];
  
  services.xserver.displayManager.sddm.theme = "catppuccin-mocha";

  nix.settings.trusted-users = ["hisa"];

  programs.command-not-found.enable = false;

  system.stateVersion = "23.05"; # alot of yip yap about changing this just read the man config whatever
}
