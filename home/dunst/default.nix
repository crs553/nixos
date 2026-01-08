
{ pkgs, config, ... }:
{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 300;
        height = 80;
        offset = "-10+10";        # position
        origin = "top-right";
        transparency = 0;
        frame_color = "#302D41";   # mantle
        separator_color = "#FAB387";
        font = "Monospace 10";
      };

      urgency_low = {
        background = "#1E1E2E";   # base
        foreground = "#A6E3A1";   # text
        timeout = 5;
      };

      urgency_normal = {
        background = "#1E1E2E";   # base
        foreground = "#F9E2AF";   # text
        timeout = 10;
      };

      urgency_critical = {
        background = "#F5C2E7";   # rosewater
        foreground = "#F38BA8";   # base
        timeout = 0;
      };
    };
  };
}
