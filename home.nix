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
    ./modules/core/quickshell
    ./modules/core/hyprland

    ./modules/applications/1password
    ./modules/dev/nvim
  ];
}
