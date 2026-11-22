{ config, pkgs, ... }:

let
  repo = "${config.home.homeDirectory}/nixos-config";
in
{
  # Required by home manager
  home.stateVersion = "26.05";

  home.username = "ami";
  home.homeDirectory = "/home/ami";

  _module.args.nixosRepo = repo;

  imports = [
    ./modules/core
    ./modules/core/hyprland
    ./modules/core/quickshell
    ./modules/core/vicinae
    ./modules/core/zsh
    ./modules/core/keyboard

    ./modules/applications/1password

    ./modules/dev
    ./modules/dev/nvim
    ./modules/dev/alacritty
    ./modules/dev/opencode
    ./modules/dev/herdr
    ./modules/dev/claude
  ];
}
