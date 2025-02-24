{ pkgs, host, options, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
      ];
      allowedUDPPorts = [
        59010
        59011
      ];
    };
  };

  environment.systemPackages = with pkgs; [ 
    # --- Network Utilities ---
    networkmanagerapplet # Network Management Tray
    wget                 # Command-Line Web Downloader
    curl                 # Command-Line HTTP Client
  ];
}
