{ config, pkgs, nixosRepo, ... }:

{
  #programs.hyprland = {
  #  enable = true;
    # withUWSM = true;
    # xwayland.enable = true;
  #};
  wayland.windowManager.hyprland.enable = true;

  programs.kitty.enable = true;

  # xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/hyprland/config";
}
