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
  services.hyprpaper.enable = true;
  programs.waybar.enable = true;

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
  };

  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = waybar & hyprpaper & dunst

    env = LIBVA_DRIVER_NAME,nvidia
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = NVD_BACKEND,direct

    monitor = DP-1, 2560x1440@144, auto, auto
    monitor = DP-2, 1920x1080@165, auto, auto
    workspace = 1, monitor:DP-1
    workspace = 2, monitor:DP-2
    workspace = 3, monitor:DP-2
    workspace = 4, monitor:DP-2

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default

    windowrulev2 = suppressevent maximize, class:.*

    bindm = $mod, mouse:272, movewindow
  '';

  #hyprpaper
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
        "temperature"
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

      "temperature" = {
        format-icons = [
          "" "" "" "" ""
        ];
        format = "{icon} {temperatureC}°C";
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
    
    #temperature {
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
}
