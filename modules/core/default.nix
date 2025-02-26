{
  inputs,
  ...
}:

{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./gaming.nix
    ./hardware.nix
    ./network.nix
    ./nh.nix
    ./packages.nix
    ./services.nix
    ./starfish.nix
    ./steam.nix
    ./stylix.nix
    ./system.nix
    ./user.nix
    ./virtualisation.nix
    ./xdg.nix
    inputs.stylix.nixosModules.stylix
  ];
}
