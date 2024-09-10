{ inputs, config, pkgs, outputs, ... }:

{
  home.username = "will";
  home.homeDirectory = "/home/will";

  imports = [ inputs.ags.homeManagerModules.default ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    firefox
    wofi
    master.discord
    unstable.osu-lazer-bin
    opentabletdriver
    godot_4
    gh
    waybar
    github-desktop
    ncspot
    google-chrome
    jetbrains.rider
    jetbrains.rust-rover
    subversion
    libsForQt5.dolphin
    prismlauncher
    steam
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    unzip
    lunarvim
    neovide
    libreoffice
    obsidian
    wl-clipboard
     opentabletdriver
  ];


  xdg.portal = {
    config.common.default = "*";
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.ags = {
    enable = true;
    
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  dconf.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
