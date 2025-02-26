{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Gaming platforms
    lutris
    heroic
    prismlauncher
    # Utilities
    mangohud
    goverlay
    gamescope
    # Proton versions
    protonup
    proton-ge-custom
    # Vulkan tools
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
  ];

  # Enable 32-bit systems
  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  # Environment variables for gaming
  environment.sessionVariables = {
    VKD3D_CONFIG = "dxr11";
    RADV_PERFTEST = "sam";
    PROTON_ENABLE_NVAPI = 1;
  };

  # Kernel tweaks
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelParams = [ "preempt=full" ];
}