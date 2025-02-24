{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      symbola
      material-icons
      noto-fonts
      fira-code
      jetbrains-mono
      font-awesome
	    terminus_font
      victor-mono
      (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    ];
  };
}
