{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Igor G.";
  gitEmail = "igor.gutchin@gmail.com";

  # Hyprland Settings
  extraMonitorSettings = "
    #monitor=DP-2,1920x1080@165, 0x360, auto
    monitor = DP-4, 1920x1080@165, 0x360, 1, bitdepth, 10
    workspace = 4, monitor:DP-4
    workspace = 5, monitor:DP-4
    workspace = 6, monitor:DP-4


    #monitor=HDMI-A-1,2560x1440@60, 1920x0, auto
    monitor = HDMI-A-5, 2560x1440@60, 1920x0, 1, bitdepth, 10
    workspace = 1, monitor:HDMI-A-5, default:true
    workspace = 2, monitor:HDMI-A-5
    workspace = 3, monitor:HDMI-A-5
  ";

  # Waybar Settings
  clock24h = false;

  # Program Options
  browser = "brave"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "ghostty"; # Set Default System Terminal
  keyboardLayout = "us";
  consoleKeyMap = "us";

}
