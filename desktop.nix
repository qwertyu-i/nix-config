# Hyprland file

{ pkgs, ... }:
let
  user = "qwertyu";
in
{
  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    hyprlock
    hypridle
    foot
    librewolf
    fuzzel
    dunst
    egl-wayland
    waybar
    # oh my god i've been staring at "org.whateverthefuck.settings is missing" for so long then i stumbled upon the fucking arch wiki page for xdg portals and saw that the hyprland portal doesn't have settings portal support holy shit
    xdg-desktop-portal-gtk
    xorg.xcursorgen
    seatd
    slurp
    grim
    wl-clipboard
    gimp
    libsixel
    vesktop
    steam
    kdePackages.dolphin
    kdePackages.qtwayland
    wireguard-tools
    brightnessctl
  ];

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
    };
  };

  xdg.portal.enable = true;

  # creating wallpapers directory in home
  systemd.tmpfiles.settings = {
    "wallpapers" = {
      "/home/${user}/.config/wallpapers".d = {
        mode = "0751";
        group = "users";
        user = user;
      };
    };
  };

  systemd.tmpfiles.settings = {
    "grand-canyon-wallpaper" = {
      "/home/qwertyu/.config/wallpapers/kevin-wang-EuTlfLqYWp8-unsplash.jpg".L = {
        mode = "0777";
        group = "users";
        user = user;
        argument = "/etc/nixos/wallpapers/kevin-wang-EuTlfLqYWp8-unsplash.jpg";
      };
    };
  };

  services.seatd.enable = true;
  programs.steam.enable = true;
}
