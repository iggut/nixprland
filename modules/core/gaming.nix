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
    # Proton toolls
    protonup-ng
    protonup-qt
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




}