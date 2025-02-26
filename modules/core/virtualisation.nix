{ pkgs, ... }:
{
  virtualisation = {
    # Containerization
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    
    # Virtual Machines
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    # Waydroid (Android container)
    waydroid.enable = true;
    lxc = {
      enable = true;
      lxcfs.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Container tools
    podman-compose
    buildah
    distrobox
    qemu_kvm
    
    # Virtualization utilities
    virt-manager
    virt-viewer
    spice-vdagent

    # Added per request
    boxbuddy
    waydroid
  ];

  # Required permissions
  services.udev.packages = [ pkgs.input-remapper ];

  # Waydroid udev rules
  services.udev.extraRules = ''
    SUBSYSTEM=="binder", OWNER="iggut", MODE="0660"
    KERNEL=="ashmem", OWNER="iggut", MODE="0660"
    KERNEL=="binder*", OWNER="iggut", MODE="0660"
  '';

}