{ config, inputs, pkgs, nixosRepo, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  wayland.windowManager.hyprland.enable = true;
  services.upower.enable = true;
  services.tuned.enable = true;
}
