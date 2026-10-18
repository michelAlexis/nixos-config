{ config, pkgs, nixosRepo, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    # systemd.variables = [ "--all" ];
  };
  
  # keep otherwise cannot open a terminal in the default config
  programs.kitty.enable = true;

  # xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/hyprland/config";
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/ami/nixos-config/modules/core/hyprland/config";
  # xdg.configFile."hypr".source = ./config;
}
