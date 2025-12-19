{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    settings = [
      {
        position = "top";
        height = 35;
        spacing = 4;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "battery"
          "clock"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}: {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            default = "";
          };
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "{}% ";
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = "";
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "🌑" "🌘" "🌗" "🌖" "🌕" ];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ " " " " " " " " " " ];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
      }
    ];

    style = ''
    @define-color rosewater #f5e0dc;
@define-color flamingo #f2cdcd;
@define-color pink #f5c2e7;
@define-color mauve #cba6f7;
@define-color red #f38ba8;
@define-color maroon #eba0ac;
@define-color peach #fab387;
@define-color yellow #f9e2af;
@define-color green #a6e3a1;
@define-color teal #94e2d5;
@define-color sky #89dceb;
@define-color sapphire #74c7ec;
@define-color blue #89b4fa;
@define-color lavender #b4befe;
@define-color text #cdd6f4;
@define-color subtext1 #bac2de;
@define-color subtext0 #a6adc8;
@define-color overlay2 #9399b2;
@define-color overlay1 #7f849c;
@define-color overlay0 #6c7086;
@define-color surface2 #585b70;
@define-color surface1 #45475a;
@define-color surface0 #313244;
@define-color base #1e1e2e;
@define-color mantle #181825;
@define-color crust #11111b;

* {
    border: none;
    border-radius: 0px;
    font-family: "DroidSansM Nerd Font";
    font-weight: bold;
    font-size: 12px;
    min-height: 0;
    transition: 0.3s;
}

window#waybar {
    background: rgba(21, 18, 27, 0);
    color: @text;
}

tooltip {
    background: @base;
    border-radius: 10px;
    border-width: 1.5px;
    border-style: solid;
    border-color: @crust;;
    transition: 0.3s;
}

#workspaces button {
    padding: 5px;
    color: @overlay0;    
    margin-right: 5px;
}

#workspaces button.active {
    color: rgba(255, 85, 85, 0.85);
}

#workspaces button.focused {
    color: @text;
    background: @maroon;
    border-radius: 20px;
}

#workspaces button.urgent {
    color: @crust;
    background: @green;
    border-radius: 20px;
}

#workspaces button:hover {
    background: @crust;
    color: @text;
    border-radius: 20px;
}

#idle_inhibitor,
#custom-power_profile,
#custom-weather,
#window,
#clock,
#battery,
#pulseaudio,
#network,
#cpu,
#memory,
#bluetooth,
#temperature,
#workspaces,
#tray,
#backlight {
    background: @base;
    opacity: 0.8;
    padding: 0px 10px;
    margin: 0;
    margin-top: 5px;
    border: 1px solid @mantle;
}

#temperature {
    border-radius: 20px 0px 0px 20px;
}

#temperature.critical {
    color: @maroon;
}

#backlight {
    border-radius: 20px 0px 0px 20px;
    padding-left: 7px;
}

#tray {
    border-radius: 20px;
    margin-right: 5px;
    padding: 0px 4px;
}

#workspaces {
    background: @base;
    border-radius: 20px;
    margin-left: 5px;
    padding-right: 0px;
    padding-left: 5px;
}

#custom-power_profile {
    color: @green;
    border-left: 0px;
    border-right: 0px;
}

#window {
    border-radius: 20px;
    margin-left: 5px;
    margin-right: 5px;
}

#clock {
    color: @peach;
    border-radius: 20px;
    margin-left: 5px;
    border-right: 0px;
    transition: 0.3s;
    padding-left: 7px;
}

#network {
    color: @yellow;
    border-radius: 20px 0px 0px 20px;
    border-left: 0px;
    border-right: 0px;
}

#bluetooth {
    color: @blue;
    border-radius: 20px;
    margin-right: 10px
} 

#pulseaudio {
    color: @blue;
    border-left: 0px;
    border-right: 0px;
}

#pulseaudio.microphone {
    color: #cba6f7;
    border-left: 0px;
    border-right: 0px;
    border-radius: 0px 20px 20px 0px;
    margin-right: 5px;
    padding-right: 8px;
}

#battery {
    color: @green;
    border-radius: 0 20px 20px 0;
    margin-right: 5px;
    border-left: 0px;
}

#custom-weather {
    border-radius: 20px;
    border-right: 0px;
    margin-left: 0px;
}    '';
  };
}

