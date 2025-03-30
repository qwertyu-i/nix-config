{ config, pkgs, ... }:
let
  user = "qwertyu";
  homedir = "/home/${user}";
in
{
  home.username = user;
  home.homeDirectory = homedir;
  
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 16;
    };

  programs.foot.enable = true;
  wayland.windowManager.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.hyprpaper.enable = true;
  services.hypridle.enable = true;
  programs.waybar.enable = true;
  services.dunst.enable = true;
  programs.fuzzel.enable = true;

  # xdg portal config because waybar is shitting itself???
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  #xdg.portal.config = {
  #  common = {
  #    default = [
  #      "gtk"
  #    ];
  #  };
  #};

  #xdg.portal.enable = true;

  # git config
  programs.git = {
    enable = true;
    userEmail = "luke.z24680@gmail.com";
    userName = "qwertyu";
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind-key l
      unbind-key Left
      unbind-key Down
      unbind-key Up
      unbind-key Right
      bind-key N last-window
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
    '';
  };

  # foot terminal configuration
  programs.foot.settings = {
    main = {
      font = "Martian Mono:size=12";
    };

    colors = {
      alpha = 0.85;
      background="282828";
      foreground="ebdbb2";
      regular0="282828";
      regular1="cc241d";
      regular2="98971a";
      regular3="d79921";
      regular4="458588";
      regular5="b16286";
      regular6="689d6a";
      regular7="a89984";
      bright0="928374";
      bright1="fb4934";
      bright2="b8bb26";
      bright3="fabd2f";
      bright4="83a598";
      bright5="d3869b";
      bright6="8ec07c";
      bright7="ebdbb2";
    };
  };

  # hyprland configuration
  wayland.windowManager.hyprland.settings = {

    "$terminal" = "foot";
    "$menu" = "fuzzel";

    general = {
      "gaps_in" = "5";
      "gaps_out" = "10";
      "border_size" = "2";
      "col.active_border" = "rgba(ebdbb2aa)";
      "col.inactive_border" = "rgba(595959aa)";
      "resize_on_border" = "true";
      "allow_tearing" = "false";
      "layout" = "master";
    };

    decoration = {
      "rounding" = "5";
      "active_opacity" = "1.0";
      "inactive_opacity" = "1.0";
      shadow = {
        "enabled" = "true";
	"range" = "4";
	"render_power" = "3";
	"color" = "rgba(1a1a1aee)";
      };
      blur = {
        "enabled" = "true";
	"size" = "3";
	"passes" = "1";
	"vibrancy" = "0.1696";
      };
    };

    "$mod" = "Mod1";

    animations = {
      "enabled" = "true";

      "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";
    };

    input = {
      "kb_layout" = "us";
      "kb_variant" = "colemak";
      "kb_options" = "caps:escape";

      "accel_profile" = "flat";

      "follow_mouse" = "1";

      "sensitivity" = "0";
    };

    device = {
      "name" = "tpps/2-elan-trackpoint";
      "sensitivity" = "0.7";
    };

    bind = [
      "$mod, Q, exec, $terminal"
      "$mod, C, killactive,"
      "$mod SHIFT, M, exit,"
      "$mod, V, togglefloating,"
      "$mod, R, exec, $menu"
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
      "$mod, M, exec, slurp | grim -g - - | wl-copy"
      "$mod, F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      "$mod, F12, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ];

    debug = {
      "disable_logs" = "false";
    };

    master = {
      "new_status" = "slave";
    };

    misc = {
      "force_default_wallpaper" = "0";
    };
  };

  wayland.windowManager.hyprland.extraConfig = ''
    monitor = eDP-1, 1920x1080@60, 0x0, 1

    exec-once = waybar & hyprpaper & dunst

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default

    windowrulev2 = suppressevent maximize, class:.*

    bindm = $mod, mouse:272, movewindow
  '';

  # hyprlock
  programs.hyprlock.extraConfig = ''

    background {
      path = screenshot
      blur_passes = 1
      blur_size = 3
    }

    input-field {
        monitor =
        size = 250, 60
        outline_thickness = 2
        dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        outer_color = rgba(235, 219, 178, 1)
        inner_color = rgba(40, 40, 40, 1)
        font_color = rgba(235, 219, 178, 1)
        fade_on_empty = false
        rounding = -1
        check_color = rgb(204, 136, 34)
        placeholder_text = <i><span foreground="##ebdbb2">put ur password poopy head</span></i>
	fail_text = <i><span foreground="##ebdbb2">???</span></i>
        hide_input = false
        position = 0, -200
        halign = center
        valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] echo "$(date +"%A, %B %d")"
      color = rgba(235, 219, 178, 1)
      font_size = 22
      font_family = Martian Mono
      position = 0, 300
      halign = center
      valign = center
    }

    label {
      monitor = 
      text = cmd[update:1000] echo "$(date +"%-H:%M")"
      color = rgba(235, 219, 178, 1)
      font_size = 95
      font_family = Martian Mono
      position = 0, 200
      halign = center
      valign = center
    }
  '';

  # hypridle
  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };
    listener = [
      {
        timeout = 300;
        on-timeout = "hyprlock";
      }
    ];
  };

  # hyprpaper
  services.hyprpaper.settings = {
    preload = [ "${homedir}/.config/wallpapers/kevin-wang-EuTlfLqYWp8-unsplash.jpg" ];
    wallpaper = [ ",${homedir}/.config/wallpapers/kevin-wang-EuTlfLqYWp8-unsplash.jpg" ];
  };

  # waybar config
  programs.waybar.settings = {
    mainBar = {
      layer = "bottom";
      position = "top";
      height = 24;

      modules-left = [
        "custom/icon"
        "tray"
        "hyprland/window"
      ];
      modules-center = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "network"
        "pulseaudio"
        "cpu"
        "battery"
        "memory"
        "clock"
      ];

      "custom/icon" = {
        format = "";
      };

      "tray" = {
        icon-size = 18;
        spacing = 10;
        show-passive-items = false;
      };

      "hyprland/window" = {
        icon = true;
        icon-size = 18;
        format = "{initialTitle}";
      };

      "hyprland/workspaces" = {
        persistent-workspaces = {
          "*" = [ 1 2 3 ];
        };
        format = "  {icon}  ";
        format-icons = {
          active = "";
          default = "";
          urgent = "";
        };
      };

      "network" = {
        format-icons = [
          "󰤯" "󰤟" "󰤢" "󰤥" "󰤨"
        ];
        format-wifi = "{icon} {essid}";
        format-disconnected = "󰤮 Disconnected";
        format = "󰤮 Disabled";
      };

      "pulseaudio" = {
          format-icons = {
            default = "";
            headphone = "";
            speaker = "";
            headset = "";
            hands-free = "";
          };
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}  {volume}%";
      };

      "cpu" = {
        format = " {usage}%";
      };

      "battery" = {
        format-icons = [
          "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"
        ];
        format = "{icon} {capacity}%";
      };

      "memory" = {
        format = " {used}GB";
      };

      "clock" = {
        tooltip-format = "{:%d/%m/%Y}";
      };
    };
  };

  # waybar style css
  programs.waybar.style = ''
    *{
      font-family: 'Martian Mono', 'Symbols Nerd Font Mono';
      font-size: 13px;
      border: none;
      color: #ebdbb2;
      padding: 0px;
      margin: 0px;
    }

    .modules-left {
      background: rgba(40,40,40,1);
      border: none;
      border-bottom-right-radius: 10px;
    }
    
    .modules-center {
      background: rgba(40,40,40,1);
      border: none;
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;
    }
    
    .modules-right {
      background: rgba(40,40,40,1);
      border: none;
      border-bottom-left-radius: 10px;
    }
    
    window#waybar {
      background: rgba(0,0,0,0);
    }
    
    #custom-icon {
      font-size: 20px;
      padding-left: 6px;
      padding-right: 6px;
      padding-top: 4px;
      padding-bottom: 4px;
      color: #ebdbb2;
    }
    
    #tray {
      padding-left: 10px;
      padding-right: 10px;
      color: #282828;
    }
    
    #tray menu {
      background: #282828;
    }
    
    #window {
      padding-left: 10px;
      padding-right: 10px;
      background: #928374;
      border-bottom-right-radius: 10px;
    }
    
    #workspaces {
      padding-left: 4px;
      padding-right: 4px;
    }
    
    window#waybar.empty #window {
      padding-left: 0px;
      padding-right: 0px;
      background: rgba(0,0,0,0)
    }
    
    window#waybar.empty #custom-icon {
      padding-right: 10px
    }
    
    #network {
    }
    
    #network.wifi {
      padding-left: 10px;
      padding-right: 10px;
      background: #458588;
      border-bottom-left-radius: 10px;
    }
    
    #network.disabled {
      padding-left: 10px;
      padding-right: 10px;
      background: #cc241d;
      border-bottom-left-radius: 10px;
    }
    
    #network.disconnected {
      padding-left: 10px;
      padding-right: 10px;
      background: #cc241d;
      border-bottom-left-radius: 10px;
    }
    
    #clock {
      padding-left: 10px;
      padding-right: 10px;
      background: #282828;
    }
    
    #pulseaudio {
      padding-left: 10px;
      padding-right: 10px;
      background: #d79921;
    }
    
    #cpu {
      padding-left: 10px;
      padding-right: 10px;
      background: #98971a;
    }
    
    #battery {
      padding-left: 10px;
      padding-right: 10px;
      background: #d65d0e;
    }
    
    #memory {
      padding-left: 10px;
      padding-right: 10px;
      background: #b16286;
    }
  '';

  # neovim configuration
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    extraLuaConfig = ''
      ${builtins.readFile ./neovim/init.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      {
      	plugin = nvim-lspconfig;
	config = toLuaFile ./neovim/plugins/lsp.lua;
      }
      {
        plugin = gruvbox-nvim;
	config = "colorscheme gruvbox";
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
      }
      {
        plugin = render-markdown-nvim;
      }
    ];
    viAlias = true;
    vimAlias = true;
  };

  services.dunst.settings = {
    global = {
      monitor = "*";

      follow = "mouse";

      width = [ "200" "600" ];

      height = 300;

      origin = "top-right";

      offset = "20x20";

      scale = 0;

      notification_limit = 20;

      progress_bar = true;

      progress_bar_height = 10;

      progress_bar_frame_width = 1;

      progress_bar_min_width = 150;

      progress_bar_max_width = 300;

      progress_bar_corner_radius = 0;

      progress_bar_corners = "all";

      icon_corner_radius = 0;

      icon_corners = "all";

      indicate_hidden = "yes";

      transparency = 0;

      separator_height = 2;

      padding = 8;

      horizontal_padding = 8;

      text_icon_padding = 0;

      frame_width = 3;

      frame_color = "#ebdbb2";

      gap_size = 0;

      separator_color = "frame";

      sort = "yes";

      font = "Martian Mono";

      line_height = 0;

      markup = "full";

      format = "<b>%s</b>\n%b";

      alignment = "left";

      vertical_alignment = "center";

      show_age_threshold = 60;

      ellipsize = "middle";

      ignore_newline = "no";

      stack_duplicates = true;

      hide_duplicate_count = false;

      show_indicators = "yes";

      enable_recursive_icon_lookup = true;

      icon_theme = "Adwaita";

      icon_position = "left";

      min_icon_size = 32;

      max_icon_size = 64;

      icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/;";

      sticky_history = "yes";

      history_length = 20;

      corner_radius = 4;

      corners = "all";

      ignore_dbusclose = false;

      force_xwayland = false;

      mouse_left_click = [ "do_action" "close_current" ];
      mouse_middle_click = [ "close_all" ];
      mouse_right_click = [ "close_current" ];
    };

    urgency_low = {
      # IMPORTANT: colors have to be defined in quotation marks.
      # Otherwise the "#" and following would be interpreted as a comment.
      background = "#282828";
      foreground = "#888888";
      timeout = 10;
      # Icon for notifications with low urgency, uncomment to enable
      #default_icon = /path/to/icon
    };

    urgency_normal = {
      background = "#282828";
      foreground = "#ffffff";
      timeout = 10;
      override_pause_level = 30;
      # Icon for notifications with normal urgency, uncomment to enable
      #default_icon = /path/to/icon
    };

    urgency_critical = {
      background = "#282828";
      foreground = "#ffffff";
      frame_color = "#ff0000";
      timeout = 0;
      override_pause_level = 60;
      # Icon for notifications with critical urgency, uncomment to enable
      #default_icon = /path/to/icon
    };
  };

  programs.fuzzel.settings = {
    main = {
      font = "Martian Mono";
    };

    border = {
      width = 2;
      radius = 5;
    };

    colors = {
      background      ="#282828ff";
      text            ="#ebdbb2ff";
      prompt          ="#458588ff";
      input           ="#ebdbb2ff";
      match           ="#458588ff";
      selection       ="#ebdbb2ff";
      selection-text  ="#282828ff";
      selection-match ="#282828ff";
      border          ="#ebdbb2ff";
    };
  };

}
