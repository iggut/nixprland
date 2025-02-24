{
  pkgs,
  lib,
  host,
  config,
  ...
}: let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../hosts/${host}/variables.nix) clock24h;
in
  with lib; {
    # Configure & Theme Waybar
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
    };
  }
