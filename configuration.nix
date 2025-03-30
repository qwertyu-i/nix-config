# Core config

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./dev.nix
      ./desktop.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/005db3e2-fe46-424b-a563-bf23e255da31";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "QwertyuDesktop"; # Define your hostname.

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Enable networking
  networking.wireless.iwd.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  console.keyMap = "colemak";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.qwertyu = {
    isNormalUser = true;
    description = "qwertyu";
    extraGroups = [ "wheel" "seat" "video" ];
  };

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    groups = [ "wheel" ];
    persist = true;
    keepEnv = true;
  }];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    usbutils
    wget
    iwd
    doas
    neovim
    git
    pulseaudio
    pipewire
    zip
  ];

  environment.variables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
