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
  };

  # vesktop...
  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;
  };

  # god i love packages they are so sexy and amazing
  environment.systemPackages = with pkgs; [
    vim
    alacritty
    nitch
    discord
    firefox
    flameshot
    spotify
    unzip
    pavucontrol
    spicetify-cli
    prismlauncher
    gparted
    fuzzel
    neovim
    grim
    slurp
    git
    gh
    gcc
    hyfetch
    wl-clipboard
    jq
    libnotify
    kitty
    vesktop
    hyprpaper
    grimblast
    cmatrix
    swaybg
  ];

  fonts.packages = with pkgs; [
    iosevka
    jetbrains-mono
    font-awesome
    (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono"];})
  ];

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
  # ..and its dumbass dependency.
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

  # Enable gtk portal for flameshot and other gtk apps
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # finallyu the gtk portal
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment? i did !!
}
