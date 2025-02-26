{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscodium
    jetbrains.idea-ultimate
    cmake
    ninja
    gnumake
    llvmPackages_16.clang
    python3Full
    nodejs
    rustup
    audacity
    discord
    nodejs
    obs-studio
  ];
}
