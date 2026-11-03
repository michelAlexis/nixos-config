{ config, pkgs, nixosRepo, ... }:

{
  # keep otherwise cannot open a terminal in the default config
  programs.kitty.enable = true;

  home.packages = [
    pkgs.hyprpaper
  ];

  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/hyprland/config";
  home.file."images/wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/hyprland/wallpapers";
}
